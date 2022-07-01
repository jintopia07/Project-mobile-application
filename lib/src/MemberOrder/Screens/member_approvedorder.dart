// @dart=2.9
import 'package:flutter/material.dart';

import '../../../constants.dart';

class MemberApprovedOrder extends StatefulWidget {
  const MemberApprovedOrder({Key key}) : super(key: key);

  @override
  _MemberApprovedOrderState createState() => _MemberApprovedOrderState();
}

class _MemberApprovedOrderState extends State<MemberApprovedOrder> {
  final List<String> _dummy = List<String>.generate(5, (index) => "Row: $index");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('รายการที่อนุมัติเรียบร้อย'),
          backgroundColor: Colors.teal[600],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 1000,
            padding: const EdgeInsets.all(defaultPadding * 1),
            child: Stack(
              children: <Widget>[
                Container(
                  child: const Text(
                    'จำนวนรายการที่อนุมัติทั้งหมด  :',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 25, bottom: 30),
                  child: _listSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listSection() => ListView.builder(
      itemCount: _dummy.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 6,
                offset: Offset(5, 6), // Shadow position
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
                _countSectionCard(),
                const SizedBox(
                  height: defaultPadding * 1,
                ),
                _paySectionCard(),
                const SizedBox(
                  height: defaultPadding * 1,
                ),
                _iconSectionCard(),
              ],
            ),
          ),
        );
      });

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
              child: const Text("วันที่ขอทำสำเนา :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("18 มกราคม 2562 เวลา 03:19"),
            ),
          ],
        ),
      );

  Widget _countSectionCard() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("จำนวนรายการ :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("1"),
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
              child: const Text("ผู้แจ้งขอทำสำเนา :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("นาย A"),
            ),
          ],
        ),
      );

  Widget _iconSectionCard() => Column(
        children: <Widget>[
          _detailFlatButton(),
          const SizedBox(
            height: defaultPadding * 1.5,
          ),
        ],
      );

  Widget _detailFlatButton() => Center(
        child: Container(
          height: 40,
          margin: const EdgeInsets.all(defaultPadding),
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding * 4.3,
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
                      AssetImage("assets/images/list2.png"),
                    ),
                  ),
                  Container(
                    color: Colors.teal[800],
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: const Text(
                      'รายละเอียด',
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
