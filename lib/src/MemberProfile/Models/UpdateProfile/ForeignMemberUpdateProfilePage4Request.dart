// @dart=2.9

import 'package:nat/src/MemberProfile/Models/memberinfo.dart';

class ForeignMemberUpdateProfilePage4Request {
  MemberInfo memberInfo;
  String cardID = "";
  String purposeID = "";
  String researchPurposeOther = "";
  String SelectedinterestingTopics_ID = "";
  String interestingTopicOther = "";
  String researchDetail = "";

  ForeignMemberUpdateProfilePage4Request(this.memberInfo) {
    cardID = memberInfo.cardID;
    if (memberInfo.researchPurpose != null) {
      purposeID = memberInfo.researchPurpose.purposeID;
    }
    researchPurposeOther = memberInfo.researchPurposeOther;
    SelectedinterestingTopics_ID = memberInfo.interestingTopicIDs;
    interestingTopicOther = memberInfo.interestingTopicOther;
    researchDetail = memberInfo.researchingDetail;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["CardID"] = cardID;
    json["purposeID"] = purposeID;
    json["ResearchPurposeOther"] = researchPurposeOther;
    json["SelectedInterestingTopics_ID"] = SelectedinterestingTopics_ID;
    json["InterestingTopicOther"] = interestingTopicOther;
    json["ResearchDetail"] = researchDetail;
    return json;
  }
}
