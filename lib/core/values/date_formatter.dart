import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDateTimeApi(DateTime date) {
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'00:00:00.000'Z'").format(date);
    return formattedDate;
  }
}
