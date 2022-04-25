import 'dart:convert';

import 'package:decimal/decimal.dart';

import 'currency_code.enum.dart';

class Price implements Comparable<Price> {
  final Decimal amount;

  final CurrencyCode currency;

  const Price(this.amount, this.currency);

  Price.fromInt(int amount, this.currency) : amount = Decimal.fromInt(amount);

  Price.fromDouble(double amount, this.currency)
      : amount = Decimal.parse(amount.toString());

  Price abs() => Price(amount.abs(), currency);

  Price converted(CurrencyCode currencyCode, double rate) =>
      Price(amount * Decimal.parse(rate.toString()), currencyCode);

  bool get isZero => amount == Decimal.zero;

  bool get isNegative => amount < Decimal.zero;

  /// Two prices are equal if their cents and currency are the same
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Price &&
        other.amount == amount &&
        other.currency == currency;
  }

  /// Compares amounts of two [Price] instances.
  ///
  /// Throws exception if currencies do not equal (see [Currency.==]).
  bool operator >(Price other) {
    if (currency != other.currency) {
      _throwCurrencyError();
    }

    return amount > other.amount;
  }

  /// Compares amounts of two [Price] instances.
  ///
  /// Throws exception if currencies do not equal (see [Currency.==]).
  bool operator >=(Price other) {
    if (currency != other.currency) {
      _throwCurrencyError();
    }

    return amount >= other.amount;
  }

  /// Compares amounts of two [Price] instances.
  ///
  /// Throws exception if currencies do not equal (see [Currency.==]).
  bool operator <(Price other) {
    if (currency != other.currency) {
      _throwCurrencyError();
    }

    return amount < other.amount;
  }

  /// Compares amounts of two [Price] instances.
  ///
  /// Throws exception if currencies do not equal (see [Currency.==]).
  bool operator <=(Price other) {
    if (currency != other.currency) {
      _throwCurrencyError();
    }

    return amount <= other.amount;
  }

  /// Adds amount of the second [Price] operand and creates new instance.
  ///
  /// Throws exception if currencies do not equal (see [Currency.==]).
  Price operator +(Price other) {
    if (currency != other.currency) {
      _throwCurrencyError();
    }
    return Price(amount + other.amount, currency);
  }

  /// Subtracts amount of the second [Price] operand and creates new instance.
  ///
  /// Throws exception if currencies do not equal (see [Currency.==]).
  Price operator -(Price other) {
    if (currency != other.currency) {
      _throwCurrencyError();
    }

    return Price(amount - other.amount, currency);
  }

  Price operator *(double scalor) {
    return Price(amount * Decimal.parse(scalor.toString()), currency);
  }

  Price operator /(double scalor) {
    final result = amount / Decimal.parse(scalor.toString());
    return Price(result.toDecimal(), currency);
  }

  @override
  int compareTo(Price other) {
    if (this > other) return 1;
    if (this < other) return -1;
    return 0;
  }

  void _throwCurrencyError() {
    throw Exception('Operations with different currencies are not supported.');
  }

  @override
  int get hashCode => amount.hashCode ^ currency.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'amount': amount.toJson(),
      'currency': currency.name,
    };
  }

  factory Price.fromMap(Map<String, dynamic> map) {
    return Price(
      Decimal.fromJson(map['amount']),
      CurrencyCode.values.byName(map['currency']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Price.fromJson(String source) => Price.fromMap(json.decode(source));

  @override
  String toString() => 'Price(amount: $amount, currency: $currency)';
}
