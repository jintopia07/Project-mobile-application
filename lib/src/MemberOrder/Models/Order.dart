// @dart=2.9
import 'dart:convert';
import 'package:http/http.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';
import 'package:nat/src/MemberOrder/Models/OrderDetail.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';

class Order {
  Order();
  int member_ID = 0;
  MemberInfo member;
  String member_UserName = "";
  String member_CardID = "";
  String member_Name = "";
  String member_SurName = "";

  String referenceNO_1 = "";
  String referenceNO_2 = "";
  PaymentSolution paymentSolution;
  BankInfo bankInfo;
  DateTime checkOut_Datetime;
  bool isCheckedOut;
  DateTime expired_DateTime;
  String reasonToCopy = "";
  double summaryPrice = 0;
  double finalPrice = 0;
  List<OrderDetail> orderDetails;

  Order.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      member_ID = json["Member_ID"];
      member_UserName = json["Member_UserName"];
      member_CardID = json["Member_CardID"];
      member_Name = json["Member_Name"];
      member_SurName = json["Member_SurName"];
      referenceNO_1 = json["ReferenceNO_1"];
      referenceNO_2 = json["ReferenceNO_2"];
      paymentSolution = PaymentSolution.fromJson(json["PaymentSolution"]);
      bankInfo = BankInfo.fromJson(json["BankInfo"]);
      if (json["CheckOut_Datetime"] != null) {
        checkOut_Datetime = DateTime.parse(json["CheckOut_Datetime"]);
      }
      isCheckedOut = json["IsCheckedOut"];
      if (json["Expired_DateTime"] != null) {
        expired_DateTime = DateTime.parse(json["Expired_DateTime"]);
      }
      reasonToCopy = json["ReasonToCopy"];
      summaryPrice = json["SumaryPrice"];
      finalPrice = json["FinalPrice"];

      Iterable iterableOrderDetails = json["OrderDetails"];
      orderDetails =
          iterableOrderDetails.map((e) => OrderDetail.fromJson(e)).toList();
    }
  }
}
