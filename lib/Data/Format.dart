import 'package:intl/intl.dart' show DateFormat;

class Format {
  static String date(DateTime dt) {
   return DateFormat("dd/MM/yyyy").format(dt);
  }
}