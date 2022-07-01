// @dart=2.9
class EmployeeProfileRequest {
  EmployeeProfileRequest(this.username);
  String username;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json['Username'] = username;
    return json;
  }
}
