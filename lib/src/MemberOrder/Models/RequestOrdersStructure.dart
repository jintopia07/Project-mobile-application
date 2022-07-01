// @dart=2.9
class RequestOrdersStructure {
  RequestOrdersStructure();
  String cardID;
  int pageNumber;
  int maxRowPerPage;

  Map<String, dynamic> createJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["CardID"] = cardID;
    json["PageNumber"] = pageNumber;
    json["MaxRowPerPage"] = maxRowPerPage;
    return json;
  }
}
