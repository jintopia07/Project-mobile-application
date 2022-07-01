// @dart=2.9
import 'package:http/http.dart' as http;
import 'package:nat/src/Register/Models/ShortMemberRegisterRequest.dart';
import 'dart:convert';

class MemberRegisterService {
  final encoding = Encoding.getByName('utf-8');
  String mainWebAPIURL;

  MemberRegisterService(this.mainWebAPIURL);

  Future<http.Response> postShortRegisterMember(
      ShortMemberRegisterRequest shortMemberRegisterRequest) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/member/shortmemberregister");

    var data = shortMemberRegisterRequest.toJson();
    var convertedData = json.encode(data);
    var response = http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    return response;
  }
}
