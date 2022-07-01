// @dart=2.9
class RequestOrderDetails {
  RequestOrderDetails();

  String branchID;
  String branchName;
  int pageNumber;
  int maxRowPerPage;

  Map<String, dynamic> createJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["BranchID"] = branchID;
    json["BranchName"] = branchName;
    json["PageNumber"] = pageNumber;
    json["MaxRowPerPage"] = maxRowPerPage;
    return json;
  }
}
