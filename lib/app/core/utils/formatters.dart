import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static String dateDisplay(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String hourDisplay(DateTime? date) {
    if (date == null) return '';
    return DateFormat('hh:mm').format(date);
  }
}
