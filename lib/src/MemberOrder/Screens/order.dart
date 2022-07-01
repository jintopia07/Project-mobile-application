// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nat/src/MemberOrder/Screens/InBasketOrder.dart';
import 'package:nat/src/MemberOrder/Screens/completedownload.dart';
import 'package:nat/src/MemberOrder/Screens/completepayment.dart';
import 'package:nat/src/MemberOrder/Screens/member_readytopayorders.dart';
import 'package:nat/src/MemberOrder/Screens/memberwaitingforapprovalorder.dart';

class Order extends StatefulWidget {
  const Order({Key key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  bool visibilitySubmit = false;
  bool visibilityPay = false;
  bool visibilitydownload = false;
  bool visibilityComplete = false;
  bool visibilityChoose = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).titleselecteditem),
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
                  _listChoose(),
                  const SizedBox(
                    height: 20,
                  ),
                  _listwaitsubmit(),
                  const SizedBox(
                    height: 20,
                  ),
                  _listfrompay(),
                  const SizedBox(
                    height: 20,
                  ),
                  _listdownload(),
                  const SizedBox(
                    height: 20,
                  ),
                  _listComplete(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listwaitsubmit() => Container(
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
                    builder: (context) => const MemberWaitingForApprovalOrder()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: Text(
                    AppLocalizations.of(context).menuorder2,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _listfrompay() => Container(
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
                    builder: (context) => const Member_ReadyToPayOrders()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: Text(
                    AppLocalizations.of(context).menuorder3,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _listdownload() => Container(
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
                MaterialPageRoute(builder: (context) => const CompletePayment()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: Text(
                    AppLocalizations.of(context).menuorder4,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _listComplete() => Container(
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
                MaterialPageRoute(builder: (context) => const CompleteDownload()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: Text(
                    AppLocalizations.of(context).menuorder5,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _listChoose() => Container(
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
                MaterialPageRoute(builder: (context) => const InBasketOrder()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: Text(
                    AppLocalizations.of(context).menuorder1,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
