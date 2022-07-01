// @dart=2.9

import 'package:nat/src/MemberProfile/Models/memberinfo.dart';

class THMemberUpdateProfilePage2Request {
  MemberInfo memberInfo;
  String cardID = "";
  String addressNO = "";
  String villageName = "";
  String moo = "";
  String subStreet = "";
  String road = "";
  String provinceCode = "";
  String districtCode = "";
  String subDistrictCode = "";
  String postCode = "";

  THMemberUpdateProfilePage2Request(this.memberInfo) {
    cardID = memberInfo.cardID;
    addressNO = memberInfo.addressNO;
    villageName = memberInfo.villageName;
    moo = memberInfo.moo;
    // subStreet =
    road = memberInfo.road;
    if (memberInfo.province != null) {
      provinceCode = memberInfo.province.provinceCode;
    }
    if (memberInfo.district != null) {
      districtCode = memberInfo.district.districtCode;
    }
    if (memberInfo.subDistrict != null) {
      subDistrictCode = memberInfo.subDistrict.subDistrictCode;
    }
    postCode = memberInfo.zipCode;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["CardID"] = cardID;
    json["AddressNO"] = addressNO;
    json["VillageName"] = villageName;
    json["Moo"] = moo;
    json["SubStreet"] = subStreet;
    json["Road"] = road;
    json["ProvinceCode"] = provinceCode;
    json["DistrictCode"] = districtCode;
    json["SubDistrictCode"] = subDistrictCode;
    json["PostCode"] = postCode;
    return json;
  }
}
