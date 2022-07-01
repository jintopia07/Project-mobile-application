// @dart=2.9
import 'package:flutter/rendering.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';

class ForeignMemberUpdateProfilePage2Request {
  MemberInfo memberInfo;
  String cardID = "";
  String foreignerAddress = "";

  ForeignMemberUpdateProfilePage2Request(this.memberInfo) {
    cardID = memberInfo.cardID;
    foreignerAddress = memberInfo.foreignerAddress;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["CardID"] = cardID;
    json["ForeignerAddress"] = foreignerAddress;
    return json;
  }
}
