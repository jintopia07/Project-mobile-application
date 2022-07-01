// @dart=2.9
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static String ConvertDateTimeToDefaultFormatDate(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
    String formatedDate = dateFormat.format(dateTime);
    return formatedDate;
  }
}
