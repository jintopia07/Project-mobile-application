// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';

class PaymentWaySelectionPage extends StatefulWidget {
  const PaymentWaySelectionPage({ Key key }) : super(key: key);

  @override
  _PaymentWaySelectionPageState createState() => _PaymentWaySelectionPageState();
}

class _PaymentWaySelectionPageState extends State<PaymentWaySelectionPage> {

   List<BankInfo> bankInfoes;
  List<PaymentSolution> paymentSolutions;
  List<DropdownMenuItem> dropdownBankInfoItems;
  List<DropdownMenuItem> dropdownPaymentSolutionItems;

  addValueToBankInfo() {
    bankInfoes = <BankInfo>[];
    bankInfoes.add(BankInfo(nameTH: 'xxxxx'));
  }

  addValueToPaymentSolution() {
    paymentSolutions = <PaymentSolution>[];
    paymentSolutions.add(PaymentSolution(solutionName: 'xxxxxxx'));
  }

  addItemToDropDownBankInfoItems() {
    dropdownBankInfoItems = bankInfoes
        .map((b) => DropdownMenuItem(
              value: b.nameTH,
              child: Text(b.nameTH),
            ))
        .toList();
  }

  addItemToDropDownPaymentSolutionItems() {
    dropdownPaymentSolutionItems = paymentSolutions
        .map((p) => DropdownMenuItem(
            value: p.solutionName, child: Text(p.solutionName)))
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addValueToBankInfo();
    addValueToPaymentSolution();
    addItemToDropDownBankInfoItems();
    addItemToDropDownPaymentSolutionItems();
  }



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Column(
        children: <Widget>[
          Image(image: const AssetImage('assets/images/payment.png')),
          DropdownButton(
            hint: const Text('เลือกธนาคาร'),
            isExpanded: true,
            items: dropdownBankInfoItems,
            onChanged: (value) {},
          ),
          DropdownButton(
            hint: const Text('ช่องทางการชำระเงิน'),
            isExpanded: true,
            items: dropdownPaymentSolutionItems,
            onChanged: (value) {},
          )
        ],
      ),
    );
  }
}
