Money library that takes care of dealing with double imprecision.


# Usage

```dart
import 'package:dart_price/dart_price.dart';
import 'package:intl/intl.dart';

void main() {
  final price = Price(1.2, CurrencyCode.EUR);
  final price2 = Price(1.1, CurrencyCode.EUR);
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

  print('format:');
  final formatter = NumberFormat.currency(
    locale: 'fr',
    name: price.currency.code.name,
    symbol: price.currency.symbol,
  );
  print(formatter.format(price.amount.toDouble()));
}

```