// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/src/MemberOrder/Models/Order.dart';
import 'package:nat/src/MemberOrder/Screens/detail_memberwaitingforapprovalorder.dart';
import 'package:nat/src/MemberOrder/Services/MemberOrderingService.dart';

class MemberWaitingForApprovalOrder extends StatefulWidget {
  const MemberWaitingForApprovalOrder({Key key}) : super(key: key);

  @override
  _MemberWaitingForApprovalOrderState createState() =>
      _MemberWaitingForApprovalOrderState();
}

class _MemberWaitingForApprovalOrderState
    extends State<MemberWaitingForApprovalOrder> {
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
    loadOrders();
    super.initState();
  }

  void loadOrders() async {
    //Get current member info.
    var authenticaedUser = await AuthenticationService.getAuthenticatedUser();
    var username = authenticaedUser.username;
    //Crate order service and load order.
    MemberOrderingService memberOrderingService =
        MemberOrderingService(WebAPI_Config.mainWebAPIURL, username);
    Orders = await memberOrderingService.getWaitingForApprovalOrders();
    setState(() {
      _body = WillPopScope(
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
                      'จำนวนรายการที่รอการอนุมัติทั้งหมด  :',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 1.5,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: defaultPadding * 1.5, bottom: defaultPadding * 3),
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
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const DetailsMemberWaitingForApprovalOrder(),
                  ),
                );
              },
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: defaultPadding * 1,
                  ),
                  _headerSectionCard(index),
                  _countSectionCard(index),
                  _paySectionCard(index),
                  const SizedBox(
                    height: defaultPadding * 1.5,
                  ),
                ],
              ),
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

  Widget _countSectionCard(int index) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
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
              child: Text(Orders[index].orderDetails.length.toString()),
            ),
          ],
        ),
      );
  Widget _paySectionCard(int index) => Container(
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
              child: const Text("จำนวนเงิน :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(Orders[index].summaryPrice.toString()),
            ),
          ],
        ),
      );
}
