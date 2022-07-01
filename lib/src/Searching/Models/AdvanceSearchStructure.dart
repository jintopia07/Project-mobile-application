// @dart=2.9

import 'package:nat/src/Searching/Models/ISearchStructure.dart';

class AdvanceSearchStructure implements ISearchStructure {
  AdvanceSearchStructure();

  String fullContentCode_Keyword = "";
  String subject_Keyword = "";
  String ownerDocumentName_Keyword = "";
  String abstract_Keyword = "";
  String microfilmNO_Keyword = "";
  String digitalFileName_Keyword = "";

  String yearType = "";
  String startYear = "";
  String endYear = "";
  String branchName = "";

  int pageNumber = 1;
  int maxRowPerPage = 10;

  Map<String, dynamic> createJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["FullContentCode_Keyword"] = fullContentCode_Keyword;
    json["Subject_Keyword"] = subject_Keyword;
    json["OwnerDocumentName_Keyword"] = ownerDocumentName_Keyword;
    json["Abstract_Keyword"] = abstract_Keyword;
    json["MicrofilmNO_Keyword"] = microfilmNO_Keyword;
    json["DigitalFileName_Keyword"] = digitalFileName_Keyword;
    json["YearType"] = yearType;
    json["StartYear"] = startYear;
    json["EndYear"] = endYear;
    json["BranchName"] = branchName;
    json["PageNumber"] = pageNumber;
    json["MaxRowPerPage"] = maxRowPerPage;
    return json;
  }
}
