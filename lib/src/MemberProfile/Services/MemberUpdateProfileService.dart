// @dart=2.9
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:nat/src/MemberProfile/Models/UpdateProfile/ForeignMemberUpdateProfilePage1Request.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/ForeignMemberUpdateProfilePage2Request.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/ForeignMemberUpdateProfilePage3Request.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/ForeignMemberUpdateProfilePage4Request.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/THMemberUpdateProfilePage1Request.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/THMemberUpdateProfilePage2Request.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/THMemberUpdateProfilePage3Request.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/THMemberUpdateProfilePage4Request.dart';

class MemberUpdateProfileService {
  final encoding = Encoding.getByName('utf-8');
  String mainWebAPIURL;
  MemberUpdateProfileService(this.mainWebAPIURL);

  Future<Response> updateTHMemberProfilePage1(
      THMemberUpdateProfilePage1Request thMemberUpdateProfilePage1Request) {
    Uri uri = Uri.parse(
        "$mainWebAPIURL/api/memberprofile/THMemberUpdateProfilePage1");
    var data = thMemberUpdateProfilePage1Request.toJson();
    var convertedData = json.encode(data);
    var response = http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    return response;
  }

  Future<Response> updateTHMemberProfilePage2(
      THMemberUpdateProfilePage2Request thMemberUpdateProfilePage2Request) {
    Uri uri = Uri.parse(
        "$mainWebAPIURL/api/memberprofile/THMemberUpdateProfilePage2");
    var data = thMemberUpdateProfilePage2Request.toJson();
    var convertedData = json.encode(data);
    var response = http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    return response;
  }

  Future<Response> updateTHMemberProfilePage3(
      THMemberUpdateProfilePage3Request thMemberUpdateProfilePage3Request) {
    Uri uri = Uri.parse(
        "$mainWebAPIURL/api/memberprofile/THMemberUpdateProfilePage3");
    var data = thMemberUpdateProfilePage3Request.toJson();
    var convertedData = json.encode(data);
    var response = http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    return response;
  }

  Future<Response> updateTHMemberProfilePage4(
      THMemberUpdateProfilePage4Request thMemberUpdateProfilePage4Request) {
    Uri uri = Uri.parse(
        "$mainWebAPIURL/api/memberprofile/THMemberUpdateProfilePage4");
    var data = thMemberUpdateProfilePage4Request.toJson();
    var convertedData = json.encode(data);
    var response = http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    return response;
  }

  Future<Response> updateForeignMemberProfilePage1(
      ForeignMemberUpdateProfilePage1Request
          foreignMemberUpdateProfilePage1Request) {
    Uri uri = Uri.parse(
        "$mainWebAPIURL/api/memberprofile/ForeignMemberUpdateProfilePage1");
    var data = foreignMemberUpdateProfilePage1Request.toJson();
    var convertedData = json.encode(data);
    var response = http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    return response;
  }

  Future<Response> updateForeignMemberProfilePage2(
      ForeignMemberUpdateProfilePage2Request
          foreignMemberUpdateProfilePage2Request) {
    Uri uri = Uri.parse(
        "$mainWebAPIURL/api/memberprofile/ForeignMemberUpdateProfilePage2");
    var data = foreignMemberUpdateProfilePage2Request.toJson();
    var convertedData = json.encode(data);
    var response = http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    return response;
  }

  Future<Response> updateForeignMemberProfilePage3(
      ForeignMemberUpdateProfilePage3Request
          foreignMemberUpdateProfilePage3Request) {
    Uri uri = Uri.parse(
        "$mainWebAPIURL/api/memberprofile/ForeignMemberUpdateProfilePage3");
    var data = foreignMemberUpdateProfilePage3Request.toJson();
    var convertedData = json.encode(data);
    var response = http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    return response;
  }

  Future<Response> updateForeignMemberProfilePage4(
      ForeignMemberUpdateProfilePage4Request
          foreignMemberUpdateProfilePage4Request) {
    Uri uri = Uri.parse(
        "$mainWebAPIURL/api/memberprofile/ForeignMemberUpdateProfilePage4");
    var data = foreignMemberUpdateProfilePage4Request.toJson();
    var convertedData = json.encode(data);
    var response = http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    return response;
  }
}
