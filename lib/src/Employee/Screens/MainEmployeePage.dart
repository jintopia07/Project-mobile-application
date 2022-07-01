// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/src/Employee/Screens/launcher_employee.dart';
import 'package:nat/src/Employee/Screens/main_reports.dart';
import 'package:nat/src/EmployeeProfile/Models/Employee.dart';
import 'package:nat/utils/apphelper.dart';
import 'package:nat/src/Authentication/Screens/loginuser.dart';
import 'package:nat/src/EmployeeOrder/Screens/employee_approved_order.dart';
import 'package:nat/src/EmployeeOrder/Screens/employee_paidorder.dart';
import 'package:nat/src/EmployeeOrder/Screens/employeewaitingforapproval.dart';
import 'package:nat/src/Infomation/Screens/aboutus.dart';
import 'package:nat/src/Infomation/Screens/natinfo.dart';
import 'package:nat/src/MemberOrder/Screens/payment.dart';
import 'package:nat/src/Report/Screens/quantityofaskingtocopy.dart';
import 'package:nat/src/Report/Screens/quantityofregistration.dart';
import 'package:nat/src/Report/Screens/quantityofresearcher.dart';
import 'package:nat/src/Report/Screens/quantityofusingarchivedocument.dart';
import 'package:nat/src/Report/Screens/summaryofarchivedata.dart';
import 'package:nat/src/Report/Screens/summarypriceofaskingtocopy.dart';
import 'package:nat/widgets/customdialog.dart';
import 'package:nat/constants.dart';

class MainEmployeePage extends StatefulWidget {
  const MainEmployeePage({Key key}) : super(key: key);

  @override
  _MainEmployeePageState createState() => _MainEmployeePageState();
}

class _MainEmployeePageState extends State<MainEmployeePage> {
  Employee employee;
  String employeeUsername;

  @override
  void initState() {
    super.initState();
    AppHelper.getCurrentEmployee().then((userName) {
      employeeUsername = userName;
      AppHelper.getEmployeeData(employeeUsername, employeeUsername)
          .then((empData) {
        setState(() {
          employee = empData;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าแรก'),
        backgroundColor: Colors.teal[600],
      ),
      drawer: (Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Text((employee != null) ? employee.displayName : ''),
                ],
              ),
            ),
            ListTile(
              title: const Text('หน้าแรก'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LauncherEmployee(),
                    ));
              },
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  Text('รายการรออนุมัติ'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '2',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmployeeWaitingForApproval()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  Text('รายการอนุมัติเรียบร้อยแล้ว'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '2',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmployeeForApprovedOrder()),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  Text('รายการชำระเงินแล้ว'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '6',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaidOrderPage()),
                );
              },
            ),
            ListTile(
              title: const Text('รายงาน'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainReportPage()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ListTile(
                title: const Text('สถิติการสมัครสมาชิก และจำนวนสมาชิก'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuantityofRegistration()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ListTile(
                title: const Text('สถิติด้านเอกสารจดหมายเหตุแต่ละประเภท'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuantityofusingarchiveDocument()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ListTile(
                title: const Text('สถิติหัวข้อของการค้นคว้า'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuantityofResearcher()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ListTile(
                title: const Text('สถิติการทำสำเนา'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuantityofAskingtoCopy()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ListTile(
                title: const Text('สถิติค่าบริการทำสำเนาออนไลน์'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SummaryPriceofAskingtoCopy()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ListTile(
                title: const Text('สถิติการขอทำสำเนาที่ชำระเงินแล้ว'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SummaryPaidofarchiveData()),
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ListTile(
                title: const Text('ออกจากระบบ'),
                leading: Image(
                  image: const AssetImage('assets/images/logout.png'),
                ),
                onTap: () {
                  customConfirmDialog(
                          context, 'Confirm', 'ยืนยันการออกจากระบบ?')
                      .then((result) {
                    if (result == ConfirmAction.ACCEPT) {
                      AppHelper.clearCurrentEmployee();
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const LoginUser();
                        },
                      ));
                    }
                  });
                },
              ),
            ),
          ],
        ),
      )),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/banner1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 210, left: 20, right: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: defaultPadding * 1,
                        ),
                        _Section1(),
                        const SizedBox(
                          height: defaultPadding * 1,
                        ),
                        _Section2(),
                        const SizedBox(
                          height: defaultPadding * 1,
                        ),
                        _Section3(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Section1() => Container(
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
                MaterialPageRoute(builder: (context) {
                  return const NatinfoPages();
                }),
              );
            },
            child: Column(
              children: [
                Container(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        child: Image.asset(
                          "assets/images/maps.png",
                          width: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: defaultPadding),
                        child: const Text(
                          "ข้อมูลการติดต่อ",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding, bottom: defaultPadding),
                  child: const Text(
                    'รายละเอียดข้อมูลการติดต่อหอจดหมายเหตุแห่งชาติส่วนกลางและส่วนภูมิภาคทั้ง 10 แห่ง',
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _Section2() => Container(
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
                MaterialPageRoute(builder: (context) {
                  return const AboutUs();
                }),
              );
            },
            child: Column(
              children: [
                Container(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        child: Image.asset(
                          "assets/images/help.png",
                          width: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: defaultPadding),
                        child: const Text(
                          "เกี่ยวกับหอจดหมายเหตุแห่งชาติ",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding, bottom: defaultPadding),
                  child: const Text(
                    'แนะนำระเบียบ ขั้นตอน กระบวนการ การใช้บริการระบบบริการเอกสารจดหมายเหตุเพื่อประชาชน',
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _Section3() => Container(
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
                MaterialPageRoute(builder: (context) {
                  return const Payment();
                }),
              );
            },
            child: Column(
              children: [
                Container(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        child: Image.asset(
                          "assets/images/list.png",
                          width: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: defaultPadding),
                        child: const Text(
                          "บริการขอทำสำเนาเอกสาร",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding, bottom: defaultPadding),
                  child: const Text(
                    'แนะนำขั้นตอน การขอทำสำเนาเอกสารจดหมายเหตุแห่งชาติ แบบออนไลน์',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
