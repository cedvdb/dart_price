import 'package:dart_price/dart_price.dart';
import 'package:intl/intl.dart';

void main() {
  final price = Price(1.2, CurrencyCode.EUR);
  final price2 = Price(1.1, CurrencyCode.EUR);

  print('format:');
  print(buildEnglishFormatter(price).format(price.amount.toDouble()));
  print(buildFrenchFormatter(price).format(price.amount.toDouble()));
  print('add:');
  print(price + price2);
  print('substract:');
  print(price - price2);
  print('scale:');
  print(price * 2);
  print('divide:');
  print(price / 2);
  print('converted:');
  print(price.converted(CurrencyCode.USD, 1.1));
  print('sort:');
  print([price, price2]..sort());
}

/// the formatters are from the intl library but prices work well with it.
NumberFormat buildFrenchFormatter(Price price) {
  return NumberFormat.currency(
    locale: 'fr',
    name: price.currency.code.name,
    symbol: price.currency.symbol,
  );
}

NumberFormat buildEnglishFormatter(Price price) {
  return NumberFormat.currency(
    locale: 'en',
    name: price.currency.code.name,
    symbol: price.currency.symbol,
  );
}
