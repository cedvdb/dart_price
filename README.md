Library to deal with money.


# Usage

```dart
  final price = Price.fromDouble(1.2, CurrencyCode.EUR);
  final price2 = Price.fromDouble(1.1, CurrencyCode.EUR);
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
```