// @dart=2.9

import 'package:nat/src/Searching/Models/ISearchStructure.dart';

class BasicSearchStructure implements ISearchStructure {
  BasicSearchStructure();

  String keyword = "";
  int keywordConditionType = 0; //0 = And , 1 = Or
  int pageNumber = 1;
  int maxRowPerPage = 10;

  Map<String, dynamic> createJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["Keyword"] = keyword;
    json["KeywordConditionType"] = keywordConditionType;
    json["PageNumber"] = pageNumber;
    json["MaxRowPerPage"] = maxRowPerPage;
    return json;
  }
}
