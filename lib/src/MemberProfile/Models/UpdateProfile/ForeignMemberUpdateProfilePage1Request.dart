// @dart=2.9
import 'dart:ffi';

import 'package:nat/src/MemberProfile/Models/memberinfo.dart';


class ForeignMemberUpdateProfilePage1Request {
  MemberInfo memberInfo;
  String cardID = "";
  String titleID = "";
  String titleNameOther = "";
  String firstName = "";
  String lastName = "";
  int gender;
  DateTime birthDate;
  String religionID = "";
  String religionOther = "";
  String nationalityID = "";
  String nationalityOther = "";
  String raceID = "";
  String raceOther = "";
  String address = "";
  String phoneNO = "";
  String email = "";

  ForeignMemberUpdateProfilePage1Request(this.memberInfo) {
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
    address = memberInfo.foreignerAddress;
    phoneNO = memberInfo.mobileNO;

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
    json["Address"] = address;
    json["PhoneNO"] = phoneNO;
    json["Email"] = email;
    return json;
  }
}
