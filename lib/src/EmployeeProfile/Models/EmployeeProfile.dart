// @dart=2.9

import 'package:nat/src/MasterData/Models/MasterData.dart';

class EmployeeProfile {
  EmployeeProfile();

  int id = 0;
  String displayName = "";
  String username = "";
  String firstName = "";
  String lastName = "";
  NATBranch natBranch;

  EmployeeProfile.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    displayName = json["DisplayName"];
    username = json["UserName"];
    firstName = json["FirstName"];
    lastName = json["LastName"];
    natBranch = NATBranch.fromJson(json["NATBranch"]);
  }
}

