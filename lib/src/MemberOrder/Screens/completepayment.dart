// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/src/MemberOrder/Models/Order.dart';
import 'package:nat/src/MemberOrder/Screens/detail_completefiledownload.dart';
import 'package:nat/src/MemberOrder/Services/MemberOrderingService.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class CompletePayment extends StatefulWidget {
  const CompletePayment({Key key}) : super(key: key);

  @override
  _CompletePaymentState createState() => _CompletePaymentState();
}

class _CompletePaymentState extends State<CompletePayment> {
  List<Order> Orders = List<Order>.empty();
  Widget _body = Center(
    child: const CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  @override
  void initState() {
    completepay();
    super.initState();
  }

  void completepay() async {
    //Get current member info.
    var authenticaedUser = await AuthenticationService.getAuthenticatedUser();
    var username = authenticaedUser.username;
    //Crate order service and load order.
    MemberOrderingService memberOrderingService =
        MemberOrderingService(WebAPI_Config.mainWebAPIURL, username);
    Orders = await memberOrderingService.getPaidOrders();

    setState(() {
      _body = WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('รายการที่ชำระเงินเรียบร้อย'),
            backgroundColor: Colors.teal[600],
          ),
          body: SingleChildScrollView(
            child: Container(
              height: 1000,
              padding: const EdgeInsets.all(defaultPadding),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: const Text(
                      'จำนวนรายการที่ชำระเงินแล้วทั้งหมด  :',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 1,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: defaultPadding * 1.5, bottom: defaultPadding * 2),
                    child: _listSection(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _listSection() => ListView.builder(
      itemCount: Orders.length,
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
                  height: defaultPadding,
                ),
                _headerSectionCard(index),
                _Number1SectionCard(index),
                const SizedBox(
                  height: defaultPadding * 1,
                ),
                _Number2SectionCard(index),
                const SizedBox(
                  height: defaultPadding,
                ),
                _iconSectionCard(index),
                const SizedBox(height: defaultPadding),
              ],
            ),
          ),
        );
      });

  Widget _headerSectionCard(int index) => Container(
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
              child: Text(Orders[index].checkOut_Datetime.toString()),
            ),
          ],
        ),
      );

  Widget _Number1SectionCard(int index) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("เลขที่อ้างอิง 1 :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(Orders[index].referenceNO_1),
            ),
          ],
        ),
      );
  Widget _Number2SectionCard(int index) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("เลขที่อ้างอิง 2 :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(Orders[index].referenceNO_2),
            ),
          ],
        ),
      );

  Widget _iconSectionCard(int index) => Column(
        children: <Widget>[
          _detailFlatButton(),
          const SizedBox(
            height: defaultPadding,
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
                      builder: (context) => const DetailsCompleteFilesDownload()));
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
}
