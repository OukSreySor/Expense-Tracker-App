import 'package:intl/intl.dart';

////
//// Utility class for formatting DateTime objects into human-readable strings
////
class DateTimeUtils {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('E d MMMM').format(dateTime); // Example: Wed 12 Feb
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime); // Example: 14:30 (24-hour format)
  }
}