import 'package:intl/intl.dart';

String formatDateWithSuffix(DateTime? date) {
  if(date != null) {
    // Get the day
    int day = date.day;

    // Determine the suffix
    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    // Get the abbreviated month
    String month = DateFormat.MMM().format(date);

    // Combine day, suffix, and month
    return "$day$suffix $month";
  } else {
    return "";
  }
}
