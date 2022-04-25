import 'package:dart_price/dart_price.dart';
import 'package:test/test.dart';
import 'package:intl/intl.dart';

void main() {
  group('Price', () {
    test('Can create price with each currency', () {
      for (final code in CurrencyCode.values) {
        final price = Price(100, code);
        expect(price, isA<Price>());
      }
    });

    test('Can equal', () {
      expect(
        Price(100, CurrencyCode.USD),
        equals(Price(100, CurrencyCode.USD)),
      );
      expect(
        Price(100, CurrencyCode.USD),
        isNot(Price(101, CurrencyCode.USD)),
      );
      expect(
        Price(100, CurrencyCode.USD),
        isNot(Price(100, CurrencyCode.EUR)),
      );
    });

    test('Can be added', () {
      expect(
        Price(100, CurrencyCode.USD) + Price(100, CurrencyCode.USD),
        equals(
          Price(200, CurrencyCode.USD),
        ),
      );

      expect(
        Price(0.2, CurrencyCode.USD) + Price(0.1, CurrencyCode.USD),
        equals(
          Price(0.3, CurrencyCode.USD),
        ),
      );
    });

    test('Can be substracted', () {
      expect(
        Price(100, CurrencyCode.USD) - Price(200, CurrencyCode.USD),
        equals(
          Price(-100, CurrencyCode.USD),
        ),
      );

      expect(
        Price(0.2, CurrencyCode.USD) - Price(0.1, CurrencyCode.USD),
        equals(
          Price(0.1, CurrencyCode.USD),
        ),
      );
    });

    test('Can be scaled', () {
      expect(
        Price(100, CurrencyCode.USD) * 2,
        equals(
          Price(200, CurrencyCode.USD),
        ),
      );

      expect(
        Price(0.01, CurrencyCode.USD) * 100,
        equals(
          Price(1, CurrencyCode.USD),
        ),
      );
    });

    test('Can be sorted', () {
      final original = [
        Price(100, CurrencyCode.EUR),
        Price(1, CurrencyCode.EUR),
        Price(10, CurrencyCode.EUR),
      ];
      final sorted = [
        Price(1, CurrencyCode.EUR),
        Price(10, CurrencyCode.EUR),
        Price(100, CurrencyCode.EUR),
      ];
      expect(original..sort(), equals(sorted));
    });

    test('Can be serialized', () {
      final original = Price(100, CurrencyCode.EUR);
      final json = original.toJson();
      final deserialized = Price.fromJson(json);
      expect(original, deserialized);
    });

    test('Can be converted', () {
      final eur = Price(0.50, CurrencyCode.EUR);
      final usd = eur.converted(CurrencyCode.USD, 1.5);
      expect(usd, equals(Price(0.75, CurrencyCode.USD)));
    });

    test('Can be formatted locally', () {
      final price = Price(2000.50, CurrencyCode.EUR);
      final formatterEn = NumberFormat.currency(
        locale: 'en',
        name: price.currency.code.name,
        symbol: price.currency.symbol,
      );
      expect(formatterEn.format(price.amount.toDouble()), equals('€2,000.50'));
      final formatterFr = NumberFormat.currency(
        locale: 'fr',
        name: price.currency.code.name,
        symbol: price.currency.symbol,
      );
      expect(
          formatterFr
              .format(price.amount.toDouble())
              // remove space unicode character for easier testing
              .replaceAll(RegExp('\\s'), ''),
          equals('2000,50€'));
    });

    test('Can be generated from a locale string', () {
      final price = Price(2000.50, CurrencyCode.EUR);
      final formatterEn = NumberFormat.currency(
        locale: 'en',
        name: price.currency.code.name,
        symbol: price.currency.symbol,
      );
      final value = formatterEn.parse('€2,000.50');
      expect(Price(value.toDouble(), CurrencyCode.EUR), equals(price));
    });
  });
}
