class Validations {
  Validations._();
  static bool foneIsValid(String fone) {
    final regex = RegExp(r'^[0-9]{11}$');
    return regex.hasMatch(fone);
  }
}
