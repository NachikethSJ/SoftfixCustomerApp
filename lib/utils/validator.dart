import 'package:intl/intl.dart';

bool isNumberValid(String contactNumber) {
  final RegExp contactNumberRegExp = RegExp(r'^[0-9]{10}$');
  return contactNumberRegExp.hasMatch(contactNumber);
}

String formatDateTime(String date, String format) {
  if (DateTime.tryParse(date) != null) {
    return DateFormat(format).format(DateTime.parse(date).toLocal());
  }
  return '';
}

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}
