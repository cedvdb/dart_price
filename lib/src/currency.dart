import 'dart:convert';

import 'currency_code.enum.dart';

part 'currency_map.dart';

class Currency {
  /// The ISO-4217 currency code (e.g. USD).
  final CurrencyCode code;

  /// The ISO-4217 currency number (e.g. 840, for USD).
  final int number;

  /// The length of the fraction part of a currency.
  ///
  /// - for `134.23` it will be `2`
  /// - for `165` it will be `0`
  /// - for `111.2` it will be `1`
  final int digits;

  /// The currency name (e.g. US Dollar).
  final String name;

  /// The currency symbol (e.g. $).
  final String symbol;

  /// Constructs currency.
  ///
  /// Currency instance is immutable.
  const Currency._({
    required this.code,
    required this.number,
    required this.digits,
    required this.name,
    required this.symbol,
  });

  /// Finds currency by ISO-4217 currency code (e.g. USD).
  factory Currency.fromCode(
    /// ISO-4217 code to look for.
    CurrencyCode code,
  ) =>
      currencyMap[code]!;

  /// Finds currency by ISO-4217 currency code (e.g. USD) as a string.
  factory Currency.fromString(
    /// ISO-4217 code to look for.
    String codeString,
  ) {
    final code = CurrencyCode.values.byName(codeString.toUpperCase());
    return currencyMap[code]!;
  }

  @override
  String toString() {
    return 'Currency(code: $code, number: $number, digits: $digits, name: $name, symbol: $symbol)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Currency &&
        other.code == code &&
        other.number == number &&
        other.digits == digits &&
        other.name == name &&
        other.symbol == symbol;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        number.hashCode ^
        digits.hashCode ^
        name.hashCode ^
        symbol.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code.name,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency.fromCode(CurrencyCode.values.byName(map['code']));
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));
}
