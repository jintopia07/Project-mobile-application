// @dart=2.9
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:path/path.dart';

class THMemberUpdateProfilePage3Request {
  MemberInfo memberInfo;
  String cardID = "";
  String careerID = "";
  String careerOther = "";
  String workOrEducationPlace = "";
  String educationID = "";
  String educationLevelOther = "";
  String fieldID = "";
  String educationFieldOther = "";

  THMemberUpdateProfilePage3Request(this.memberInfo) {
    cardID = memberInfo.cardID;
    if (memberInfo.career != null) careerID = memberInfo.career.careerID;
    careerOther = memberInfo.careerOther;
    workOrEducationPlace = memberInfo.workOrEducationPlace;
    if (memberInfo.educationLevel != null) {
      educationID = memberInfo.educationLevel.educationID;
    }
    educationLevelOther = memberInfo.educationLevelOther;
    if (memberInfo.fieldID != null) fieldID = memberInfo.fieldID;
    educationFieldOther = memberInfo.educationFieldother;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["CardID"] = cardID;
    json["CareerID"] = careerID;
    json["CareerOther"] = careerOther;
    json["WorkOrEducationPlace"] = workOrEducationPlace;
    json["EducationID"] = educationID;
    json["EducationLevelOther"] = educationLevelOther;
    json["FieldID"] = fieldID;
    json["EducationFieldOther"] = educationFieldOther;
    return json;
  }
}
