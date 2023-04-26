class Validations {
  Validations._();
  static bool foneIsValid(String? value) {
    final number = (value ?? "").replaceAll(RegExp(r'[^0-9]'), '');
    return (number.trim().length >= 10);
  }
}
