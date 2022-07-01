// @dart=2.9
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nat/src/MemberProfile/Models/memberinfo.dart';

class MemberActivity {
  String mainWebAPIUrl;
  MemberActivity(this.mainWebAPIUrl);

  Future<MemberInfo> getMemberData(String memberCardID) async {
   MemberInfo member;
    var respResult = await http
        .get(Uri.parse('$mainWebAPIUrl/api/member/$memberCardID'));
    if (respResult.statusCode == 200) {
      member = MemberInfo.fromJson(json.decode(respResult.body));
      if (member!= null) {
        return member;
      } else {
        return null;
      }
    }
    return member;
  }

  Future<http.Response> createMember(MemberInfo memberInfo) async {
    http.Response response = await http.post(
        Uri.parse('$mainWebAPIUrl/api/MemberPostStringBody'),
        body: json.encode(memberInfo.createJson()));
    return response;
  }
}
