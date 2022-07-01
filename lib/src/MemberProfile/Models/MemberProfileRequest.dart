// @dart=2.9
class MemberProfileRequest {
  MemberProfileRequest(this.cardID);
  String cardID;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json['CardID'] = cardID;
    return json;
  }
}
