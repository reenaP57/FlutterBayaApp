import 'package:intl/intl.dart';

class DateFormatter {

  String getDateWithFormat(int timestamp, String format) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    DateFormat df = DateFormat('dd MMM yyyy', 'en_US');
    return df.format(date);
  }
}
