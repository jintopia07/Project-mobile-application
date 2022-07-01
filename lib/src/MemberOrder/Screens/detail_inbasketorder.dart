// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';

class DetailInBasketOrder extends StatefulWidget {
  const DetailInBasketOrder({Key key}) : super(key: key);

  @override
  _DetailInBasketOrderState createState() => _DetailInBasketOrderState();
}

class _DetailInBasketOrderState extends State<DetailInBasketOrder> {
  final _formKey = GlobalKey<FormState>();

  List<BankInfo> bankInfoes;
  List<PaymentSolution> paymentSolutions;
  List<DropdownMenuItem> dropdownBankInfoItems;
  List<DropdownMenuItem> dropdownPaymentSolutionItems;

  addValueToBankInfo() {
    bankInfoes = <BankInfo>[];
    bankInfoes.add(BankInfo(nameTH: 'ธนาคารกรุงไทย (KTB)'));
  }

  addValueToPaymentSolution() {
    paymentSolutions = <PaymentSolution>[];
    paymentSolutions
        .add(PaymentSolution(solutionName: 'ชำระผ่านบริการ Bill Payment'));
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
      appBar: AppBar(
        title: const Text('รายละเอียดการขอทำสำเนา'),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 6,
                    offset: const Offset(5, 6), // Shadow position
                  ),
                ],
              ),
              child: Card(
                margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: defaultPadding * 1,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 1,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: defaultPadding, top: defaultPadding),
                        child: const Text(
                          "รายละเอียดการขอทำสำเนา",
                          style: TextStyle(
                              fontWeight: FontWeight.w100, fontSize: 16),
                        ),
                      ),
                    ),
                    _headerSectionCard(),
                    _countpaySectionCard(),
                    const SizedBox(
                      height: defaultPadding * 1,
                    ),
                    _resonSectionCard(),
                    const SizedBox(
                      height: defaultPadding * 1.5,
                    ),
                    _chooseforpay(),
                    const SizedBox(
                      height: defaultPadding * 1.5,
                    ),
                    _choosebankforpay(),
                    const SizedBox(
                      height: defaultPadding * 1.5,
                    ),
                    _confirmFlatButton(),
                    const SizedBox(
                      height: defaultPadding * 1.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerSectionCard() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: defaultPadding, top: defaultPadding),
              child: const Text("จำนวนรายการ"),
            ),
            Center(
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  ),
                  isDense: true, // Added this
                  contentPadding: const EdgeInsets.all(12),
                ),
                onChanged: (value) {
                  //memberInfo.firstName = value;
                },
              ),
            ),
          ],
        ),
      );

  Widget _countpaySectionCard() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: defaultPadding, top: defaultPadding),
              child: const Text("จำนวนเงิน"),
            ),
            Center(
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  isDense: true, // Added this
                  contentPadding: const EdgeInsets.all(12),
                ),
                onChanged: (value) {
                  //memberInfo.firstName = value;
                },
              ),
            ),
          ],
        ),
      );

  Widget _resonSectionCard() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: defaultPadding, top: defaultPadding),
              child: const Text("เหตุผลในการขอทำสำเนา"),
            ),
            Center(
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  isDense: true, // Added this
                  contentPadding: const EdgeInsets.all(12),
                ),
                onChanged: (value) {
                  //memberInfo.firstName = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'เหตุผลในการขอทำสำเนา';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      );

  Widget _chooseforpay() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: defaultPadding),
              child: const Text("เลือกรูปแบบการชำระเงิน"),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              padding:
                  const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    underline: const SizedBox(),
                    hint: const Text('เลือกรูปแบบการชำระเงิน'),
                    isExpanded: true,
                    //value: selectedsolutionName,
                    items: dropdownPaymentSolutionItems,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _choosebankforpay() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: defaultPadding),
              child: const Text("เลือกธนาคาร"),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              padding:
                  const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    underline: const SizedBox(),
                    hint: const Text('เลือกธนาคาร'),
                    isExpanded: true,
                    //value: selectednameTH,
                    items: dropdownBankInfoItems,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _confirmFlatButton() => Center(
        child: Container(
          margin: const EdgeInsets.all(defaultPadding),
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding * 5,
          ),
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.teal[800]),
              textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.white)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 1)),
            ),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: const ImageIcon(
                      AssetImage("assets/images/list2.png"),
                    ),
                  ),
                  Container(
                    color: Colors.teal[800],
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: const Text(
                      'ยืนยัน',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
