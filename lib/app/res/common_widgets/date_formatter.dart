// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DateFormatter {
  final DateTime dateTime;

  DateFormatter(this.dateTime);

  // Format time as "11:00 am"
  String getTimeIn12HourFormat() {
    return DateFormat('hh:mm a').format(dateTime);
  }

  // Format date as "20 July 2027"
  String getFullDateFormat() {
    return DateFormat('d MMMM yyyy').format(dateTime);
  }

  // Format date as "20/5/2025"
  String getShortDateFormat() {
    return DateFormat('d/M/yyyy').format(dateTime);
  }

  // Format date and time as "20 July 2027, 11:00 am"
  String getDateTimeFormat() {
    return DateFormat('d MMMM yyyy, hh:mm a').format(dateTime);
  }

  // Format relative time (e.g., "2 hours ago" or "20 January 2025" for > 7 days)
  String getRelativeTimeFormat() {
    final Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 7) {
      return DateFormat('d MMMM yyyy').format(dateTime);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} min ago';
    } else {
      return 'Just now';
    }
  }
}