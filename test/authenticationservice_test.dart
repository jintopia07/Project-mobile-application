// @dart=2.9
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/Authentication/Models/AuthenticatedUser.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/src/EmployeeProfile/Services/EmployeeProfileService.dart';
import 'package:nat/src/MemberProfile/Services/MemberProfileService.dart';

void main() async {
  AuthenticationService authenticationService =
      AuthenticationService(WebAPI_Config.mainWebAPIURL);

  String username = "";
  String password = "";
  AuthenticatedUser authenticatedUser =
      await authenticationService.authen(username, password);

  if (authenticatedUser != null) {
    await authenticationService.saveAuthenticatedUser(authenticatedUser);
    var saveResult = await AuthenticationService.getAuthenticatedUser();

    username = saveResult.username;
    var role = saveResult.GetRole();
    if (role == UserRole.employee) {
      EmployeeProfileService employeeProfileService =
          EmployeeProfileService(WebAPI_Config.mainWebAPIURL);
      var employeeProfile =
          await employeeProfileService.getEmployeeProfile(username);
    } else if (role == UserRole.member) {
      MemberProfileService memberProfileService =
          MemberProfileService(WebAPI_Config.mainWebAPIURL);
      var memberProfile = await memberProfileService.getMemberProfile(username);
    }
  }
}
