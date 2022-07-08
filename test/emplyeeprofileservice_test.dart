// @dart=2.9
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/EmployeeProfile/Services/EmployeeProfileService.dart';

void main() async {
  EmployeeProfileService employeeProfileService =
      EmployeeProfileService(WebAPI_Config.mainWebAPIURL);

  String username = "";
  var employeeProfile =
      await employeeProfileService.getEmployeeProfile(username);
}
