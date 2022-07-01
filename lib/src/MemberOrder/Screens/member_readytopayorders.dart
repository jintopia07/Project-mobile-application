// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/src/MemberOrder/Models/Order.dart';
import 'package:nat/src/MemberOrder/Screens/detail_member_readytopayorders.dart';
import 'package:nat/src/MemberOrder/Screens/qrforpayment.dart';
import 'package:nat/src/MemberOrder/Services/MemberOrderingService.dart';
import 'package:nat/constants.dart';

class Member_ReadyToPayOrders extends StatefulWidget {
  const Member_ReadyToPayOrders({Key key}) : super(key: key);

  @override
  Member_ReadyToPayOrdersState createState() => Member_ReadyToPayOrdersState();
}

class Member_ReadyToPayOrdersState extends State<Member_ReadyToPayOrders> {
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
    loadreadytopay();
    super.initState();
  }

  void loadreadytopay() async {
    //Get current member info.
    var authenticaedUser = await AuthenticationService.getAuthenticatedUser();
    var username = authenticaedUser.username;
    //Crate order service and load order.
    MemberOrderingService memberOrderingService =
        MemberOrderingService(WebAPI_Config.mainWebAPIURL, username);
    Orders = await memberOrderingService.getReadyToPayOrders();

    setState(() {
      _body = WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('รายการที่พร้อมจ่ายเงิน'),
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
                      'จำนวนรายการที่พร้อมชำระเงินทั้งหมด  :',
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
                    builder: (context) => const DetailMember_ReadyToPayOrders(),
                  ),
                );
              },
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: defaultPadding * 1,
                  ),
                  _headerSectionCard(index),
                  _Number1SectionCard(index),
                  const SizedBox(
                    height: defaultPadding * 1,
                  ),
                  _Number2SectionCard(index),
                  const SizedBox(
                    height: defaultPadding * 1,
                  ),
                  _countSectionCard(index),
                  const SizedBox(
                    height: defaultPadding * 1,
                  ),
                  _paySectionCard(index),
                  const SizedBox(
                    height: defaultPadding * 1,
                  ),
                  _iconSectionCard(),
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

  Widget _Number1SectionCard(int index) => Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
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
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
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
  Widget _countSectionCard(int index) => Container(
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
              child: Text(Orders[index].orderDetails.length.toString()),
            ),
          ],
        ),
      );
  Widget _paySectionCard(int index) => Container(
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
              child: Text(Orders[index].summaryPrice.toString()),
            ),
          ],
        ),
      );
  Widget _iconSectionCard() => Column(
        children: <Widget>[
          _detailFlatButton(),
          const SizedBox(height: defaultPadding * 0.2),
          _payFlatButton(),
          const SizedBox(height: defaultPadding * 1.5),
        ],
      );

  Widget _detailFlatButton() => Center(
        child: Container(
          margin: const EdgeInsets.all(defaultPadding),
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding * 4,
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QRforPayment(),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
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

  Widget _payFlatButton() => Center(
        child: Container(
          margin: const EdgeInsets.all(defaultPadding),
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding * 4,
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
                      AssetImage("assets/images/pdf.png"),
                    ),
                  ),
                  Container(
                    color: Colors.teal[800],
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: const Text(
                      'ชำระเงิน',
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
