// @dart=2.9
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nat/utils/DateHelper.dart';

void main() async {
  Intl.defaultLocale = "th";
  initializeDateFormatting();

  DateTime targetDate = DateTime.now();
  String formatedDate =
      DateHelper.ConvertDateTimeToDefaultFormatDate(targetDate);
  print(formatedDate);
}
