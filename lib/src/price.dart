import 'dart:convert';

import 'package:decimal/decimal.dart';

import 'currency.dart';
import 'currency_code.enum.dart';

class Price implements Comparable<Price> {
  final Decimal amount;

  final Currency currency;

  const Price._(this.amount, this.currency);

  Price(double amount, CurrencyCode currencyCode)
      : amount = Decimal.parse(amount.toString()),
        currency = Currency.fromCode(currencyCode);

  Price abs() => Price._(amount.abs(), currency);

  Price converted(CurrencyCode currencyCode, double rate) => Price._(
        amount * Decimal.parse(rate.toString()),
        Currency.fromCode(currencyCode),
      );

  bool get isZero => amount == Decimal.zero;

  bool get isNegative => amount < Decimal.zero;

  /// Two prices are equal if their amount and currency are the same
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
    return Price._(amount + other.amount, currency);
  }

  /// Subtracts amount of the second [Price] operand and creates new instance.
  ///
  /// Throws exception if currencies do not equal (see [Currency.==]).
  Price operator -(Price other) {
    if (currency != other.currency) {
      _throwCurrencyError();
    }

    return Price._(amount - other.amount, currency);
  }

  Price operator *(num scalor) {
    return Price._(amount * Decimal.parse(scalor.toString()), currency);
  }

  Price operator /(num scalor) {
    final result = amount / Decimal.parse(scalor.toString());
    return Price._(result.toDecimal(), currency);
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
      'currency': currency.toJson(),
    };
  }

  factory Price.fromMap(Map<String, dynamic> map) {
    return Price._(
      Decimal.fromJson(map['amount']),
      Currency.fromJson(map['currency']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Price.fromJson(String source) => Price.fromMap(json.decode(source));

  @override
  String toString() => 'Price(amount: $amount, currency: $currency)';
}
