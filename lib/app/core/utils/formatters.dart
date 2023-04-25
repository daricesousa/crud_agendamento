class Formatters {
  Formatters._();

  static String dateDisplay(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return "$day/$month/$year";
  }

  static String hourDisplay(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return "${hour}h$minute";
  }

  static String foneDisplay(String fone) {
    return fone;
    final ddd = fone.substring(0, 2);
    final first = fone.substring(2, 7);
    final second = fone.substring(7, 11);
    return "($ddd) $first-$second";
  }
}
