/// These functions are healper functions
/// that are used throughout the app
import 'package:intl/intl.dart';

String getMonthString(date) {
  DateTime dt = new DateFormat("yyyy-MM-dd").parse(date);
  final DateFormat formatter = DateFormat('MMMMd');
  final String formatted = formatter.format(dt);
  return formatted.substring(0, 3);
}

String getDateString(date) {
  DateTime dt = new DateFormat("yyyy-MM-dd").parse(date);
  final DateFormat formatter = DateFormat('MMMMEEEEd');
  final String formatted = formatter.format(dt);
  return formatted.substring(0, 2);
}

String getDateNum(date) {
  DateTime dt = new DateFormat("yyyy-MM-dd").parse(date);
  final DateFormat formatter = DateFormat('D');
  final String formatted = formatter.format(dt);
  return formatted;
}

String getDateNumSingle(date) {
  DateTime dt = new DateFormat("yyyy-MM-dd").parse(date);
  final DateFormat formatter = DateFormat('d');
  final String formatted = formatter.format(dt);
  return formatted;
}

String getDateStringAndDate(date) {
  DateTime dt = new DateFormat("yyyy-MM-dd").parse(date);
  final DateFormat formatter = DateFormat('MMMEd');
  final String formatted = formatter.format(dt);

  return formatted;
}

String getYear(date) {
  DateTime dt = new DateFormat("yyyy-MM-dd").parse(date);
  final DateFormat formatter = DateFormat('y');
  final String formatted = formatter.format(dt);

  return formatted;
}

String formatDate(date) {
  return DateFormat('yyyy-MM-dd').format(date);
}
