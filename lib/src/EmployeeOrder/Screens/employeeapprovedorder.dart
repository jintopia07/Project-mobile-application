// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/UI_Config.dart';
import 'package:nat/constants.dart';

import 'details_approval_order.dart';

class EmployeeApprovedOrder extends StatefulWidget {
  const EmployeeApprovedOrder({Key key}) : super(key: key);

  @override
  _EmployeeApprovedOrderState createState() => _EmployeeApprovedOrderState();
}

class _EmployeeApprovedOrderState extends State<EmployeeApprovedOrder> {
  final List<String> _dummy = List<String>.generate(5, (index) => "Row: $index");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        // appBar: AppBar(
        //  // title: Text('รายการที่อนุมัติเรียบร้อย'),
        //   //backgroundColor: Colors.teal[600],
        // ),
        body: SingleChildScrollView(
          child: Container(
            height: 1000,
            padding: const EdgeInsets.all(defaultPadding * 1),
            child: Stack(
              children: <Widget>[
                Container(
                  child: const Text(
                    'รายการที่พิจารณาเรียบร้อย  :',
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
                _nameSectionCard(),
                _reasonSectionCard(),
                const SizedBox(
                  height: defaultPadding * 1,
                ),
                _daySectionCard(),
                const SizedBox(
                  height: defaultPadding * 1,
                ),
                _statusSectionCard(),
                const SizedBox(
                  height: defaultPadding * 1,
                ),
                _dayforapproveSectionCard(),
                const SizedBox(
                  height: defaultPadding * 1,
                ),
                _imageSectionCard(),
                _iconSectionCard(),
              ],
            ),
          ),
        );
      });

  Widget _nameSectionCard() => Container(
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
              child: const Text("ผู้ขอทำสำเนา :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("นางสาว เสาวนีย์ ปราบหงษ์"),
            ),
          ],
        ),
      );

  Widget _reasonSectionCard() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("เหตุผลในการขอทำสำเนา :"),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: const Text("ประกอบรายงาน"),
              ),
            ),
          ],
        ),
      );
  Widget _daySectionCard() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("วันที่ขอทำสำเนา :"),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: const Text("10 กุมภาพันธ์ 2565 เวลา 11:28"),
              ),
            ),
          ],
        ),
      );

  Widget _statusSectionCard() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("ผลการพิจารณา :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("อนุมัติ"),
            ),
          ],
        ),
      );

  Widget _dayforapproveSectionCard() => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("วันที่ทำการอนุมัติ :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text(
                "10 กุมภาพันธ์ 2565",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );

  // Widget _listpicSection() => Container(
  //       height: 500,
  //       child: ListView.builder(
  //           itemCount: _dummy.length,
  //           itemBuilder: (context, index) {
  //             return Container(
  //               margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
  //               child: Column(
  //                 children: <Widget>[
  //                   SizedBox(
  //                     height: defaultPadding * 1,
  //                   ),
  //                   _imageSectionCard(index),
  //                   SizedBox(
  //                     height: defaultPadding * 1.5,
  //                   ),
  //                 ],
  //               ),
  //             );
  //           }),
  //     );

  Widget _imageSectionCard() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: UI_Config.defaultPadding / 2,
        ),
        child: Column(
          children: <Widget>[
            // Container(
            //   height: 50,
            //   width: 50,
            //   child: FadeInImage(
            //     height: 50,
            //     width: 50,
            //     placeholder: AssetImage('assets/images/picempty.png'),
            //     image: NetworkImage(
            //       WebSite_Config.mainWebSiteURLWithSAndDigitalFileFolder +
            //           "/" +
            //           orderDetails[index].digitalFile.storedPathThumnail,
            //     ),
            //   ),
            // ),

            Image.asset(
              "assets/images/NATPratum.png",
              width: double.infinity,
              height: 100,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: const Text(
                "NAT-PO52386.jpg",
              ),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailsApprovalOrder(),
                ),
              );
            },
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
