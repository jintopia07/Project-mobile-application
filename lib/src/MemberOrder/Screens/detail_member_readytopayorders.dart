// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/UI_Config.dart';
import 'package:nat/src/MemberOrder/Models/Order.dart';
import 'package:nat/src/MemberOrder/Models/OrderDetail.dart';

import '../../../constants.dart';

class DetailMember_ReadyToPayOrders extends StatefulWidget {
  const DetailMember_ReadyToPayOrders({Key key}) : super(key: key);

  @override
  _DetailMember_ReadyToPayOrdersState createState() =>
      _DetailMember_ReadyToPayOrdersState();
}

class _DetailMember_ReadyToPayOrdersState
    extends State<DetailMember_ReadyToPayOrders> {
  List<Order> orders = List<Order>.empty();
  List<OrderDetail> orderDetails = List<OrderDetail>.empty();
  final List<String> _dummy = List<String>.generate(10, (index) => "Row: $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดรายการที่พร้อมจ่ายเงิน'),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                offset: Offset(4, 8), // Shadow position
              ),
            ],
          ),
          margin: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: <Widget>[
              _Detailtopayorder(),
              _paytoOrderbutton(),
              Container(
                padding: const EdgeInsets.only(bottom: defaultPadding * 3),
                child: _listSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Detailtopayorder() => Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: defaultPadding, top: defaultPadding),
                    child: const Text(
                      "รายละเอียดรายการขอทำสำเนา",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.brown,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Divider(
                color: Colors.grey,
                height: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text(
                      "วันที่ขอทำสำเนา :",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text(
                      "22 ธันวาคม 2564 เวลา 10:09",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text("เลขที่อ้างอิง 1 :",
                        style: TextStyle(color: Colors.brown)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text(
                      "1210313452",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text("เลขที่อ้างอิง 2 :",
                        style: TextStyle(color: Colors.brown)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text(
                      "2112290000030000",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text("จำนวนรายการ :",
                        style: TextStyle(color: Colors.brown)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text(
                      "6 รายการ",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text("จำนวนเงิน :",
                        style: TextStyle(color: Colors.brown)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text(
                      "300.00 บาท",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _paytoOrderbutton() => Padding(
        padding: const EdgeInsets.only(top: defaultPadding * 1),
        child: Column(
          children: [
            Container(
              height: 50,
              margin: const EdgeInsets.all(defaultPadding),
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 5,
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
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 1)),
                ),
                onPressed: () {
                  //  Navigator.push(context,
                  //     MaterialPageRoute(
                  //   builder: (context) {
                  //     return DetailsMediaPages();
                  //   },
                  // ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 10, 0),
                        child: Image(
                          image: const AssetImage('assets/images/cart.png'),
                          color: Colors.white,
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
            Container(
              child: Divider(
                color: Colors.grey,
                height: 40,
              ),
            ),
          ],
        ),
      );

  Widget _listSection() => SizedBox(
        height: 500,
        child: ListView.builder(
            itemCount: _dummy.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: defaultPadding * 1,
                    ),
                    _imageSectionCard(index),
                    const SizedBox(
                      height: defaultPadding * 1.5,
                    ),
                  ],
                ),
              );
            }),
      );

  Widget _imageSectionCard(int index) => Padding(
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
              "assets/images/NATCheangMai.png",
              width: double.infinity,
              height: 150,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: const Text(
                "na01d-neg0000001-0008.jpg",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding * 0.5),
              child: const Text(
                'หอจดหมายเหตุแห่งชาติเฉลิมพระเกียรติพระบาทสมเด็จพระเจ้าอยู่หัวภูมิพลอดุลยเดช',
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              alignment: FractionalOffset.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'ผลการพิจารณา :',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding * 0.8),
                    child: const Text(
                      "อนุมัติ",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              alignment: FractionalOffset.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'วันที่อนุมัติ :',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding * 0.8),
                    child: const Text(
                      "22 ธันวาคม 2564 เวลา 10:12",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              child: Divider(
                color: Colors.grey,
                height: 40,
              ),
            ),
          ],
        ),
      );
}
