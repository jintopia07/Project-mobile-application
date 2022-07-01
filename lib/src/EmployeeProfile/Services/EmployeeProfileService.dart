// @dart=2.9
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nat/src/EmployeeProfile/Models/EmployeeProfileRequest.dart';
import 'package:nat/src/EmployeeProfile/Models/EmployeeProfile.dart';

class EmployeeProfileService {
  final encoding = Encoding.getByName('utf-8');
  String mainWebAPIURL;
  EmployeeProfileService(this.mainWebAPIURL);

  Future<EmployeeProfile> getEmployeeProfile(String username) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/employee/getemployeeprofile");
    EmployeeProfileRequest employeeProfileRequest =
        EmployeeProfileRequest(username);
    var mapJson = employeeProfileRequest.toJson();
    var convertedJson = json.encode(mapJson);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedJson,
        encoding: encoding);
    if (response.statusCode == 200) {
      var returnedBody = response.body;
      var convertedBody = json.decode(returnedBody);
      var employeeProfile = EmployeeProfile.fromJson(convertedBody);
      return employeeProfile;
    }
    return null;
  }
}
