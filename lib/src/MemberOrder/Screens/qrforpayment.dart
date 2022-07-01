// @dart=2.9
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../constants.dart';

class QRforPayment extends StatefulWidget {
  const QRforPayment({Key key}) : super(key: key);

  @override
  _QRforPaymentState createState() => _QRforPaymentState();
}

class _QRforPaymentState extends State<QRforPayment> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ชำระเงิน'),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
          padding: const EdgeInsets.all(defaultPadding * 1.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImage(
                data: controller.text,
                size: 250,
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              buildTextFied(context),
              detailforpayment(),
              adpayment(),
            ],
          ),
        )),
      ),
    );
  }

  Widget buildTextFied(BuildContext context) => TextField(
        controller: controller,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: 'Enter the data',
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white),
          ),
          suffixIcon: IconButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(
              Icons.done,
              size: 30,
            ),
            onPressed: () {
              setState(() {});
            },
          ),
        ),
      );

  Widget detailforpayment() => SizedBox(
        height: 350,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
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
                  children: <Widget>[
                    const SizedBox(
                      height: defaultPadding * 1,
                    ),
                    _headerSectionCard(),
                    _Number1SectionCard(),
                    const SizedBox(
                      height: defaultPadding * 1,
                    ),
                    _Number2SectionCard(),
                    const SizedBox(
                      height: defaultPadding * 1,
                    ),
                    _dateSectionCard(),
                    const SizedBox(
                      height: defaultPadding * 1,
                    ),
                    _paySectionCard(),
                    const SizedBox(
                      height: defaultPadding * 1,
                    ),
                    _payFlatButton(),
                    const SizedBox(
                      height: defaultPadding * 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _headerSectionCard() => Container(
        padding: const EdgeInsets.symmetric(
          //horizontal: defaultPadding,
          vertical: defaultPadding / 1,
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("ชื่อผู้ชำระเงิน :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(
                "นาย สิทธิโชค นาท้าว",
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ],
        ),
      );

  Widget _Number1SectionCard() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("รหัสผู้ชำระเงิน (Ref.1) :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(
                "1210114557",
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ],
        ),
      );

  Widget _Number2SectionCard() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("รหัสอ้างอิง (Ref.2) :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(
                "2112300000010000",
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ],
        ),
      );

  Widget _dateSectionCard() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("วันครบกำหนดชำระ :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(
                "30 Dec 2021",
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ],
        ),
      );

  Widget _paySectionCard() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("จำนวนเงิน :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(
                "100",
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ],
        ),
      );

  Widget _payFlatButton() => Center(
        child: Container(
          height: 40,
          margin: const EdgeInsets.all(defaultPadding),
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding * 4,
          ),
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
                      AssetImage("assets/images/pdf.png"),
                    ),
                  ),
                  Container(
                    color: Colors.teal[800],
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: const Text(
                      'บันทึก',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget adpayment() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text(
                "ชำระผ่านทางอิเล็กทรอนิกส์",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: defaultPadding, bottom: defaultPadding),
              child: const Text("(ATM/Internet/Mobile Banking)*"),
            ),
            const SizedBox(height: defaultPadding),
            Center(
              child: Image.asset(
                "assets/images/bank.png",
                width: 300,
              ),
            ),
          ],
        ),
      );
}
