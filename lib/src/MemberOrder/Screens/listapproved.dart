// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/src/EmployeeOrder/Screens/employee_approved_order.dart';
import 'package:nat/src/EmployeeOrder/Screens/employee_paidorder.dart';
import 'package:nat/src/EmployeeOrder/Screens/employeewaitingforapproval.dart';

class ListApproved extends StatefulWidget {
  const ListApproved({Key key}) : super(key: key);

  @override
  _ListApprovedState createState() => _ListApprovedState();
}

class _ListApprovedState extends State<ListApproved> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('รายการอนุมัติ'),
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
                    _listwaitapproved(),
                    const SizedBox(
                      height: 20,
                    ),
                    _listcomplete(),
                    const SizedBox(
                      height: 20,
                    ),
                    _paylistcomplete(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _listwaitapproved() => Container(
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
                    builder: (context) => const EmployeeWaitingForApproval()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: const Text(
                    "รายการที่รอการอนุมัติ",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _listcomplete() => Container(
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
                    builder: (context) => const EmployeeForApprovedOrder()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: const Text(
                    "รายการที่อนุมัติเรียบร้อย",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _paylistcomplete() => Container(
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
                MaterialPageRoute(builder: (context) => const PaidOrderPage()),
              );
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 20),
                  child: const Text(
                    "รายการที่ชำระเงินเรียบร้อย",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
