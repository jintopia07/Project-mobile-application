// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nat/src/EmployeeProfile/Models/EmployeeProfile.dart';
import 'package:nat/src/MemberProfile/Models/MemberPhoto.dart';
import 'package:nat/src/MemberProfile/Models/MemberPhotoRequest.dart';
import 'package:nat/src/MemberProfile/Models/MemberProfileRequest.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';

class MemberProfileService {
  final encoding = Encoding.getByName('utf-8');
  String mainWebAPIURL = "";
  MemberProfileService(this.mainWebAPIURL);

  Future<MemberInfo> getMemberProfile(String cardID) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/memberprofile/getmemberprofile");
    MemberProfileRequest memberProfileRequest = MemberProfileRequest(cardID);
    var mapJson = memberProfileRequest.toJson();
    var convertedJson = json.encode(mapJson);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedJson,
        encoding: encoding);
    if (response.statusCode == 200) {
      var returnedBody = response.body;
      var convertedBody = json.decode(returnedBody);
      var memberProfile = MemberInfo.fromJson(convertedBody);
      return memberProfile;
    }
    return null;
  }

  Future<MemberPhoto> getMemberPhoto(String cardID) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/memberprofile/getmemberphoto");
    MemberPhotoRequest memberPhotoRequest = MemberPhotoRequest(cardID);
    var mapJson = memberPhotoRequest.toJson();
    var convertedJson = json.encode(mapJson);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedJson,
        encoding: encoding);
    if (response.statusCode == 200) {
      var returnedBody = response.body;
      var convertedBody = json.decode(returnedBody);
      var memberPhoto = MemberPhoto.fromJson(convertedBody);
      return memberPhoto;
    }
    return null;
  }
}
