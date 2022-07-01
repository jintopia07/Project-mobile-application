// @dart=2.9

import 'package:nat/src/MemberProfile/Models/memberinfo.dart';

class THMemberUpdateProfilePage4Request {
  MemberInfo memberInfo;
  String cardID = "";
  String purposeID = "";
  String researchPurposeOther = "";
  String selectedInterestingTopics_ID = "";
  String interestingTopicOther = "";
  String researchDetail = "";

  THMemberUpdateProfilePage4Request(this.memberInfo) {
    cardID = memberInfo.cardID;
    if (memberInfo.researchPurpose != null) {
      purposeID = memberInfo.researchPurpose.purposeID;
    }
    researchPurposeOther = memberInfo.researchPurposeOther;
    selectedInterestingTopics_ID = memberInfo.interestingTopicIDs;
    interestingTopicOther = memberInfo.interestingTopicOther;
    researchDetail = memberInfo.researchingDetail;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["CardID"] = cardID;
    json["PurposeID"] = purposeID;
    json["ResearchPurposeOther"] = researchPurposeOther;
    json["SelectedInterestingTopics_ID"] = selectedInterestingTopics_ID;
    json["InterestingTopicOther"] = interestingTopicOther;
    json["ResearchDetail"] = researchDetail;
    return json;
  }
}
