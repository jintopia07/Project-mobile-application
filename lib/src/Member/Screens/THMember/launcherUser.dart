// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nat/src/Member/Screens/THMember/mainmemberpage.dart';
import 'package:nat/src/MemberOrder/Screens/order.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Screens/MemberProfileEng/profile_member_eng.dart';
import 'package:nat/src/MemberProfile/Screens/MemberProfileThai/profile_member.dart';
import 'package:nat/src/Searching/Screens/searcher.dart';

class LauncherUser extends StatefulWidget {
  MemberInfo memberInfo;
  LauncherUser(this.memberInfo);
  static const routeName = '/menulauncher';

  @override
  _LauncherUserState createState() => _LauncherUserState();
}

class _LauncherUserState extends State<LauncherUser> {
  MemberInfo memberInfo;
  int _selectedIndex = 0;
  final List<Widget> _pageWidget = <Widget>[
    const MainMemberPage(),
    Searcher(),
    const Order(),
    const Profile_Memberpages(),
  ];

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getWidgetByIndex(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context).launcherUser1,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: AppLocalizations.of(context).launcherUser2,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_basket),
            label: AppLocalizations.of(context).launcherUser3,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context).launcherUser4,
          ),
        ],
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
