class UnknownCurrencyException implements Exception {
  final String details;
  const UnknownCurrencyException(this.details);

  @override
  String toString() => 'UnknowCurrencyException(details: $details)';
}
