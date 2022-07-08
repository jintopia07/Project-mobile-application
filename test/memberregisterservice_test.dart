// @dart=2.9
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/Register/Services/MemberRegisterService.dart';
import 'package:nat/src/Register/Models/ShortMemberRegisterRequest.dart';

void main() async {
  MemberRegisterService memberRegisterService =
      MemberRegisterService(WebAPI_Config.mainWebAPIURL);

  ShortMemberRegisterRequest shortMemberRegisterRequest = ShortMemberRegisterRequest();
  shortMemberRegisterRequest.cardID = "";

  var result = await memberRegisterService
      .postShortRegisterMember(shortMemberRegisterRequest);

  if (result.statusCode == 200) {
  } else {
    var returnMessage = result.body;
  }
}
