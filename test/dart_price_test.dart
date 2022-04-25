import 'package:dart_price/dart_price.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  group('Price', () {
    test('Can create price with each currency', () {
      for (final code in CurrencyCode.values) {
        final price = Price.fromInt(100, code);
        expect(price, isA<Price>());
      }
    });

    test('Can equal', () {
      expect(
        Price.fromInt(100, CurrencyCode.USD),
        equals(Price.fromInt(100, CurrencyCode.USD)),
      );

      expect(
        Price.fromInt(100, CurrencyCode.USD),
        equals(Price.fromDouble(100, CurrencyCode.USD)),
      );
      expect(
        Price.fromInt(100, CurrencyCode.USD),
        equals(Price(Decimal.fromInt(100), CurrencyCode.USD)),
      );
      expect(
        Price.fromInt(100, CurrencyCode.USD),
        isNot(Price.fromInt(101, CurrencyCode.USD)),
      );
      expect(
        Price.fromInt(100, CurrencyCode.USD),
        isNot(Price.fromInt(100, CurrencyCode.EUR)),
      );
    });

    test('Can be added', () {
      expect(
        Price.fromInt(100, CurrencyCode.USD) +
            Price.fromInt(100, CurrencyCode.USD),
        equals(
          Price.fromInt(200, CurrencyCode.USD),
        ),
      );

      expect(
        Price.fromDouble(0.2, CurrencyCode.USD) +
            Price.fromDouble(0.1, CurrencyCode.USD),
        equals(
          Price.fromDouble(0.3, CurrencyCode.USD),
        ),
      );
    });

    test('Can be substracted', () {
      expect(
        Price.fromInt(100, CurrencyCode.USD) -
            Price.fromInt(200, CurrencyCode.USD),
        equals(
          Price.fromInt(-100, CurrencyCode.USD),
        ),
      );

      expect(
        Price.fromDouble(0.2, CurrencyCode.USD) -
            Price.fromDouble(0.1, CurrencyCode.USD),
        equals(
          Price.fromDouble(0.1, CurrencyCode.USD),
        ),
      );
    });

    test('Can be scaled', () {
      expect(
        Price.fromInt(100, CurrencyCode.USD) * 2,
        equals(
          Price.fromInt(200, CurrencyCode.USD),
        ),
      );

      expect(
        Price.fromDouble(0.01, CurrencyCode.USD) * 100,
        equals(
          Price.fromInt(1, CurrencyCode.USD),
        ),
      );
    });

    test('Can be sorted', () {
      final original = [
        Price.fromInt(100, CurrencyCode.EUR),
        Price.fromInt(1, CurrencyCode.EUR),
        Price.fromInt(10, CurrencyCode.EUR),
      ];
      final sorted = [
        Price.fromInt(1, CurrencyCode.EUR),
        Price.fromInt(10, CurrencyCode.EUR),
        Price.fromInt(100, CurrencyCode.EUR),
      ];
      expect(original..sort(), equals(sorted));
    });

    test('Can be serialized', () {
      final original = Price.fromInt(100, CurrencyCode.EUR);
      final json = original.toJson();
      final deserialized = Price.fromJson(json);
      expect(original, deserialized);
    });

    test('Can be converted', () {
      final eur = Price.fromDouble(0.50, CurrencyCode.EUR);
      final usd = eur.converted(CurrencyCode.USD, 1.5);
      expect(usd, equals(Price.fromDouble(0.75, CurrencyCode.USD)));
    });

    test('Can be formatted', () {});
  });
}
