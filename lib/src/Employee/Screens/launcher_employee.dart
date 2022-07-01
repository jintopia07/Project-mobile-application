// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/src/Employee/Screens/MainEmployeePage.dart';
import 'package:nat/src/Employee/Screens/main_reports.dart';
import 'package:nat/src/MemberOrder/Screens/listapproved.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';

class LauncherEmployee extends StatefulWidget {
  const LauncherEmployee({Key key}) : super(key: key);

  @override
  _LauncherEmployeeState createState() => _LauncherEmployeeState();
}

class _LauncherEmployeeState extends State<LauncherEmployee> {
   MemberInfo memberInfo;

  int _selectedIndex = 0;
  final List<Widget> _pageWidget = <Widget>[
    const MainEmployeePage(),
    const MainReportPage(),
    const ListApproved(),
    // MemberProfileEngPage1(memberInfo),
  ];
  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'หน้าแรก',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: 'รายงาน',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'รายการอนุมัติ',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'ข้อมูลผู้ใช้งาน',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
