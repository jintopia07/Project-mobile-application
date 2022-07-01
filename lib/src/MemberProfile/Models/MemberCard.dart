// @dart=2.9

import 'package:nat/src/MasterData/Models/MasterData.dart';

class MemberCard{
  String memberCardID; // The individual card id of member.
  String userNO;
  String cardYearTHFormat;
  DateTime cardCreatedDate;
  DateTime cardExpiredDate;
  int natBranchID;
  NATBranch natBranch;
  int branchID;
}
