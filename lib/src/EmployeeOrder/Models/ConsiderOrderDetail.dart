// @dart=2.9
class ConsiderOrderDetail {
  int orderDetail_ID;
  int employeeProfile_ID;
  int approvalStatus;
  String unApprovedReason;

  Map<String, dynamic> createJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["OrderDetail_ID"] = orderDetail_ID;
    json["EmployeeProfile_ID"] = employeeProfile_ID;
    json["ApprovalStatus"] = approvalStatus;
    json["UnApprovedReason"] = unApprovedReason;
    return json;
  }
}
