// @dart=2.9
class ShortMemberRegisterRequest {
  String cardID;
  String firstName;
  String lastName;
  String email;
  String nationalityID;
  String nationalityOther;
  String titleNameID;
  String titleNameOther;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["CardID"] = cardID;
    json["FirstName"] = firstName;
    json["LastName"] = lastName;
    json["Email"] = email;
    json["TitleNameID"] = titleNameID;
    json["TitleNameOther"] = titleNameOther;
    json["NationalityID"] = nationalityID;
    json["NationalityOther"] = titleNameOther;
    return json;
  }
}
