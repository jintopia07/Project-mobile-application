// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/UI_Config.dart';
import 'package:nat/src/EmployeeOrder/Screens/unapprove_order.dart';

import '../../../constants.dart';
import 'detail_waitingforapprovalorder.dart';

class EmployeeWaitingForApproval extends StatefulWidget {
  const EmployeeWaitingForApproval({Key key}) : super(key: key);

  @override
  _EmployeeWaitingForApprovalState createState() =>
      _EmployeeWaitingForApprovalState();
}

class _EmployeeWaitingForApprovalState
    extends State<EmployeeWaitingForApproval> {
  final List<String> _dummy = List<String>.generate(5, (index) => "Row: $index");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('รายการที่รออนุมัติ'),
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
                    'รายการที่ต้องทำการพิจารณาอนุมัติ  :',
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
                  height: defaultPadding * 2,
                ),
                _headerSectionCard(),
                _resonSectionCard(),
                _copySectionCard(),
                _countSectionCard(),
                const SizedBox(
                  height: defaultPadding * 1,
                ),
                _imageSectionCard(),
                const SizedBox(
                  height: defaultPadding * 1,
                ),
                _iconSectionCard(),
                const SizedBox(
                  height: defaultPadding * 1,
                ),
              ],
            ),
          ),
        );
      });

  Widget _headerSectionCard() => Container(
        padding: const EdgeInsets.symmetric(
          //horizontal: defaultPadding,

          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(),
              child: const Text("ผู้ขอทำสำเนา :"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: const Flexible(child: Text("นาย ศิวพัฒน์ บุญยาง")),
              ),
            ),
          ],
        ),
      );

  Widget _resonSectionCard() => Container(
        padding: const EdgeInsets.symmetric(
          //horizontal: defaultPadding,
          vertical: defaultPadding / 1,
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(),
                child: const Text("เหตุผลในการขอทำสำเนา :"),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: const Flexible(child: Text("ทดสอบการขอทำสำเนา")),
              ),
            ),
          ],
        ),
      );

  Widget _copySectionCard() => Container(
        padding: const EdgeInsets.symmetric(
          //horizontal: defaultPadding,

          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(),
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
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding / 1, vertical: defaultPadding),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(),
                child: const Text("พิจารณาก่อนวันที่ :"),
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: const Text("28 มกราคม 2562 "),
              ),
            ),
          ],
        ),
      );

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
          _approvedFlatButton(),
          const SizedBox(height: defaultPadding * 1.5),
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
                  builder: (context) => const DetailsWaitingForApprovalOrder(),
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
                        horizontal: defaultPadding / 3),
                    child: const ImageIcon(
                      AssetImage("assets/images/list2.png"),
                    ),
                  ),
                  Container(
                    color: Colors.teal[800],
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 3),
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

  Widget _approvedFlatButton() => Center(
        child: Container(
          height: 40,
          margin: const EdgeInsets.all(defaultPadding),
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.teal[800]),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(color: Colors.white)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 1)),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(),
                          child: const Icon(Icons.check),
                        ),
                        Container(
                          color: Colors.teal[800],
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          child: const Text(
                            'อนุมัติ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 1.5,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(color: Colors.white)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 1)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UnApproveOrder(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(),
                          child: const Icon(Icons.sync_problem),
                        ),
                        Container(
                          color: Colors.red[600],
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          child: const Text(
                            'ไม่อนุมัติ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
