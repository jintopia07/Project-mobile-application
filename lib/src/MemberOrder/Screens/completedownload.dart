// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/src/MemberOrder/Models/Order.dart';
import 'package:nat/src/MemberOrder/Services/MemberOrderingService.dart';

class CompleteDownload extends StatefulWidget {
  const CompleteDownload({Key key}) : super(key: key);

  @override
  _CompleteDownloadState createState() => _CompleteDownloadState();
}

class _CompleteDownloadState extends State<CompleteDownload> {
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
    downloadfile();
    super.initState();
  }

  void downloadfile() async {
    //Get current member info.
    var authenticaedUser = await AuthenticationService.getAuthenticatedUser();
    var username = authenticaedUser.username;
    //Crate order service and load order.
    MemberOrderingService memberOrderingService =
        MemberOrderingService(WebAPI_Config.mainWebAPIURL, username);
    Orders = await memberOrderingService.getCompltedDownloadingOrders();

    setState(() {
      _body = WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('รายการที่ดาวน์โหลดไฟล์'),
            backgroundColor: Colors.teal[600],
          ),
          body: SingleChildScrollView(
            child: Container(
              height: 1000,
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: const Text(
                      'จำนวนรายการดาวน์โหลดไฟล์เรียบร้อยทั้งหมด  :',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25, bottom: 50),
                    child: _listSection(),
                  ),
                  const SizedBox(
                    height: defaultPadding * 1,
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
                _iconSectionCard(),
              ],
            ),
          ),
        );
      });

  Widget _headerSectionCard(int index) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 2,
          vertical: defaultPadding / 1,
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
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
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
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
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

  Widget _iconSectionCard() => Column(
        children: <Widget>[
          _detailFlatButton(),
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
