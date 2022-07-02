// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Report/Screens/quantityofaskingtocopy.dart';
import 'package:nat/src/Report/Screens/quantityofregistration.dart';
import 'package:nat/src/Report/Screens/quantityofresearcher.dart';
import 'package:nat/src/Report/Screens/quantityofusingarchivedocument.dart';
import 'package:nat/src/Report/Screens/summaryofarchivedata.dart';
import 'package:nat/src/Report/Screens/summarypriceofaskingtocopy.dart';

class MainReportPage extends StatefulWidget {
  const MainReportPage({Key key}) : super(key: key);

  @override
  _MainReportPageState createState() => _MainReportPageState();
}

class _MainReportPageState extends State<MainReportPage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('รายงาน'),
          backgroundColor: Colors.teal[600],
        ),
        body: Container(
          height: 800,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              height: 1000,
              margin: const EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  _quantityofusingarchivedocument(),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  _quantityofregistration(),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  _quantityofresearcher(),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  _quantityofaskingtocopy(),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  _summarypriceofaskingtocopy(),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  _summaryofarchivedata(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _quantityofregistration() => Container(
        width: MediaQuery.of(context).size.width * 0.9,
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const QuantityofRegistration()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: const Text(
                    "สถิติการสมัครสมาชิกและจำนวนสมาชิก",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _quantityofusingarchivedocument() => Container(
        width: MediaQuery.of(context).size.width * 0.9,
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const QuantityofusingarchiveDocument()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: const Text(
                    "สถิติด้านเอกสารจดหมายเหตุแต่ละประเภท",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _quantityofaskingtocopy() => Container(
        width: MediaQuery.of(context).size.width * 0.9,
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const QuantityofAskingtoCopy()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: const Text(
                    "สถิติการทำสำเนา",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _quantityofresearcher() => Container(
        width: MediaQuery.of(context).size.width * 0.9,
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuantityofResearcher()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: const Text(
                    "สถิติการค้นคว้า",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _summarypriceofaskingtocopy() => Container(
        width: MediaQuery.of(context).size.width * 0.9,
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SummaryPriceofAskingtoCopy()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: const Text(
                    "สถิติค่าบริการทำสำเนาออนไลน์",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _summaryofarchivedata() => Container(
        width: MediaQuery.of(context).size.width * 0.9,
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SummaryPaidofarchiveData()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: const Text(
                    "สถิติการขอทำสำเนาที่ชำระเงินแล้ว",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
