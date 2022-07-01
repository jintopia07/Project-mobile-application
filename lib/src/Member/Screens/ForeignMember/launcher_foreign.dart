// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/src/Member/Screens/THMember/mainmemberpage.dart';
import 'package:nat/src/MemberOrder/Screens/order.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Screens/MemberProfileEng/profile_member_eng.dart';
import 'package:nat/src/MemberProfile/Screens/MemberProfileThai/profile_member.dart';
import 'package:nat/src/Searching/Screens/searcher.dart';

class LauncherForeignMember extends StatefulWidget {
  MemberInfo memberInfo;
  LauncherForeignMember(this.memberInfo);

  @override
  State<LauncherForeignMember> createState() => _LauncherForeignMemberState();
}

class _LauncherForeignMemberState extends State<LauncherForeignMember> {
   MemberInfo memberInfo;
  int _selectedIndex = 0;
  final List<Widget> _pageWidget = <Widget>[
    const MainMemberPage(),
    Searcher(),
    const Order(),
    const Profile_Member_Engpages(),

  ];
  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Searcher',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_basket),
      label: 'Order',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

   Widget getWidgetByIndex(int widgetIndex) {
    switch (widgetIndex) {
      case 0:
        return const MainMemberPage();
      case 1:
        return Searcher();
      case 2:
        return const Order();
      case 3:
        if (memberInfo.isForeigner) {
          return const Profile_Member_Engpages();
        } else {
          return const Profile_Memberpages();
        }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getWidgetByIndex(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void initState() {
    memberInfo = widget.memberInfo;
    super.initState();
  }
}
