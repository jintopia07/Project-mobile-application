// @dart=2.9

import 'package:nat/src/MemberProfile/Models/memberinfo.dart';

class THMemberUpdateProfilePage1Request {
  MemberInfo memberInfo;
  String cardID = "";
  String titleID = "";
  String titleNameOther = "";
  String firstName = "";
  String lastName = "";
  int gender;
  DateTime birthDate;
  String religionID = "";
  String religionOther = " ";
  String nationalityID = "";
  String nationalityOther = "";
  String raceID = "";
  String raceOther = "";
  DateTime cardIssuedDate;
  DateTime cardExpiredDate;
  String cardIssuedPlace = "";
  String phoneNO = "";
  String fax = "";
  String email = "";

  THMemberUpdateProfilePage1Request(this.memberInfo) {
    cardID = memberInfo.cardID;
    if (memberInfo.titleName != null) titleID = memberInfo.titleName.titleID;
    titleNameOther = memberInfo.titleNameOther;
    firstName = memberInfo.firstName;
    lastName = memberInfo.lastName;
    gender = memberInfo.gender;
    if (memberInfo.birthDate != null) birthDate = memberInfo.birthDate;
    if (memberInfo.religion != null) {
      religionID = memberInfo.religion.religionID;
    }
    religionOther = memberInfo.religionOther;
    if (memberInfo.nationality != null) {
      nationalityID = memberInfo.nationality.natinalityID;
    }
    nationalityOther = memberInfo.nationalityother;
    if (memberInfo.race != null) raceID = memberInfo.race.raceID;
    raceOther = memberInfo.raceOther;
    if (memberInfo.cardIssueDate != null) {
      cardIssuedDate = memberInfo.cardIssueDate;
    }
    if (memberInfo.cardExpireDate != null) {
      cardExpiredDate = memberInfo.cardExpireDate;
    }
    if (memberInfo.cardIssuePlace != null) {
      cardIssuedPlace = memberInfo.cardIssuePlace;
    }
    phoneNO = memberInfo.mobileNO;
    fax = memberInfo.fax;
    email = memberInfo.email;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["CardID"] = cardID;
    json["TitleID"] = titleID;
    json["TitleNameOther"] = titleNameOther;
    json["FirstName"] = firstName;
    json["LastName"] = lastName;
    json["Gender"] = gender;
    json["BirthDate"] = birthDate.toIso8601String();
    json["ReligionID"] = religionID;
    json["ReligionOther"] = religionOther;
    json["NationalityID"] = nationalityID;
    json["NationalityOther"] = nationalityOther;
    json["RaceID"] = raceID;
    json["RaceOther"] = raceOther;
    json["CardIssuedDate"] = cardIssuedDate.toIso8601String();
    json["CardExpiredDate"] = cardExpiredDate.toIso8601String();
    json["CardIssuedPlace"] = cardIssuedPlace;
    json["PhoneNO"] = phoneNO;
    json["Fax"] = fax;
    json["Email"] = email;
    return json;
  }
}
