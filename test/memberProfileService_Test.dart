// @dart=2.9
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MemberProfile/Services/MemberProfileService.dart';

void main() async {
  MemberProfileService memberProfileService =
      MemberProfileService(WebAPI_Config.mainWebAPIURL);
  String cardID = "";
  var memberPhoto = await memberProfileService.getMemberPhoto(cardID);
  var memberProfile = await memberProfileService.getMemberProfile(cardID);
  var testValue = memberProfile.email;
  
}
