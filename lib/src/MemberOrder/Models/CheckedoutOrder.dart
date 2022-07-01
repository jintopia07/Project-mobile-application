// @dart=2.9

import 'package:nat/src/MasterData/Models/MasterData.dart';

class CheckoutOrder {
  CheckoutOrder() {
    paymentSolution = PaymentSolution();
    bankInfo = BankInfo();
  }

  String cardID;
  int orderID;
  PaymentSolution paymentSolution;
  BankInfo bankInfo;
  String reasonToCopy;

  Map<String, dynamic> createJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["CardID"] = cardID;
    json["OrderID"] = orderID;
    json["PaymentSolution"] = paymentSolution.createJson();
    json["BankInfo"] = bankInfo.createJson();
    json["ReasonToCopy"] = reasonToCopy;
    return json;
  }
}
