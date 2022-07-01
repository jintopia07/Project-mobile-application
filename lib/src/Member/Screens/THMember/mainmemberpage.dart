// @dart=2.9
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nat/src/Authentication/Models/AuthenticatedUser.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/Infomation/Screens/aboutus.dart';
import 'package:nat/src/Infomation/Screens/launcher.dart';
import 'package:nat/src/Infomation/Screens/natinfo.dart';
import 'package:nat/src/Member/Screens/THMember/launcherUser.dart';
import 'package:nat/src/MemberOrder/Screens/InBasketOrder.dart';
import 'package:nat/src/MemberOrder/Screens/listapproved.dart';
import 'package:nat/src/MemberOrder/Screens/member_approvedorder.dart';
import 'package:nat/src/MemberOrder/Screens/memberwaitingforapprovalorder.dart';
import 'package:nat/src/MemberOrder/Screens/payment.dart';
import 'package:nat/src/MemberProfile/Models/MemberPhoto.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Services/MemberProfileService.dart';
import 'package:nat/utils/apphelper.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/utils/memberactivity.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Authentication/Screens/loginuser.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/src/MemberProfile/Screens/MemberProfileEng/MemberProfileEngPage1.dart';
import 'package:nat/src/MemberProfile/Screens/MemberProfileThai/memberprofilethpage1.dart';
import 'package:nat/src/Searching/Screens/searcher.dart';
import 'package:nat/utils/memberactivity.dart';
import 'package:nat/widgets/customdialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nat/widgets/language_picker_widget.dart';

class MainMemberPage extends StatefulWidget {
  const MainMemberPage({Key key}) : super(key: key);

  @override
  _MainMemberPageState createState() => _MainMemberPageState();
}

class _MainMemberPageState extends State<MainMemberPage> {
  MemberActivity memberActivity = MemberActivity(WebAPI_Config.mainWebAPIURL);
  DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
  MemberProfileService memberProfileService =
      MemberProfileService(WebAPI_Config.mainWebAPIURL);
  String currentMemberCard;
  MemberInfo memberInfo;
  MemberPhoto memberPhoto;

  Widget getPageToGoToProfilePage() {
    if (memberInfo != null) {
      if (memberInfo.isForeigner == true) {
        return MemberProfileEngPage1(memberInfo);
      } else {
        return MemberProfileTHPage1(memberInfo);
      }
    }
    return null;
  }

  Widget _body = Center(
    child: const CircularProgressIndicator(),
  );

  logOut() async {
    await AuthenticationService.clearAuthenticatedUser();
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Launcher(),
        ),
        (Route<dynamic> route) => false);
  }

  showConfirmDialog() async {
    ConfirmAction result = await AppHelper.alertConfirmDialog(
      context,
      'Confirm',
      'Do you want to logout.',
    );

    if (result == ConfirmAction.ACCEPT) {
      logOut();
    }
  }

  Image getMemberImage() {
    return (memberPhoto != null)
        ? Image.memory(memberPhoto.bytes)
        : Image.asset("assets/images/profile.png");
  }

  @override
  void initState() {
    loadProfileMenu();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loadProfileMenu();
    super.didChangeDependencies();
  }

  void loadProfileMenu() async {
    AuthenticationService.getAuthenticatedUser().then((authenticatedUser) => {
          memberProfileService
              .getMemberProfile(authenticatedUser.username)
              .then((memberProfile) => {
                    memberProfileService
                        .getMemberPhoto(authenticatedUser.username)
                        .then((returnedMemberPhoto) => {
                              setState(() => {
                                    memberPhoto = returnedMemberPhoto,
                                    memberInfo = memberProfile,
                                    _body = Scaffold(
                                      appBar: AppBar(
                                        title: Text(AppLocalizations.of(context)
                                            .titlehome),
                                        backgroundColor: Colors.teal[600],
                                        actions: [
                                          LanguagePickerWidget(),
                                          const SizedBox(width: 12),
                                        ],
                                      ),
                                      drawer: Drawer(
                                          child: ListView(
                                        children: <Widget>[
                                          DrawerHeader(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0),
                                                  child: SizedBox(
                                                    height: 80,
                                                    width: 80,
                                                    child: (memberPhoto != null)
                                                        ? Image.memory(
                                                            memberPhoto.bytes)
                                                        : Image.asset(
                                                            "assets/images/profile.png",
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                ),
                                                Text((memberInfo != null)
                                                    ? memberInfo.displayName
                                                    : ''),
                                                Text((memberInfo != null)
                                                    ? memberInfo.cardID
                                                    : '')
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              AppLocalizations.of(context)
                                                  .tabmenuforuser1,
                                            ),
                                            leading: Image(
                                              image: const AssetImage(
                                                  'assets/images/home.png'),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LauncherUser(
                                                            memberInfo),
                                                  ));
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                                AppLocalizations.of(context)
                                                    .tabmenuforuser2),
                                            leading: Image(
                                              image: const AssetImage(
                                                  'assets/images/find.png'),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Searcher(),
                                                  ));
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              AppLocalizations.of(context)
                                                  .tabmenuforuser3,
                                            ),
                                            leading: Image(
                                              image: const AssetImage(
                                                  'assets/images/cart.png'),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const InBasketOrder(),
                                                ),
                                              );
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              AppLocalizations.of(context)
                                                  .tabmenuforuser4,
                                            ),
                                            leading: Image(
                                              image: const AssetImage(
                                                  'assets/images/checklist.png'),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Payment(),
                                                ),
                                              );
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                defaultPadding, 0, 0, 0),
                                            child: ListTile(
                                              title: Row(children: <Widget>[
                                                Text(
                                                    AppLocalizations.of(context)
                                                        .tabmenuforuser5),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text(
                                                  '1',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ]),
                                              leading: Image(
                                                image: const AssetImage(
                                                    'assets/images/checklist.png'),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MemberWaitingForApprovalOrder(),
                                                    ));
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                defaultPadding, 0, 0, 0),
                                            child: ListTile(
                                              title: Row(
                                                children: <Widget>[
                                                  Text(
                                                    AppLocalizations.of(context)
                                                        .tabmenuforuser6,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    '10',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              leading: Image(
                                                image: const AssetImage(
                                                    'assets/images/checklist.png'),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MemberApprovedOrder(),
                                                    ));
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                defaultPadding, 0, 0, 0),
                                            child: ListTile(
                                              title: Text(
                                                AppLocalizations.of(context)
                                                    .tabmenuforuser7,
                                              ),
                                              leading: Image(
                                                image: const AssetImage(
                                                    'assets/images/checklist.png'),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ListApproved(),
                                                    ));
                                              },
                                            ),
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text(
                                              AppLocalizations.of(context)
                                                  .tabmenuforuser8,
                                            ),
                                            leading: Image(
                                              image: const AssetImage(
                                                  'assets/images/user.png'),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          getPageToGoToProfilePage()));
                                            },
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text(
                                              AppLocalizations.of(context)
                                                  .tabmenuforuser9,
                                            ),
                                            leading: Image(
                                              image: const AssetImage(
                                                  'assets/images/information.png'),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return const AboutUs();
                                                }),
                                              );
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              AppLocalizations.of(context)
                                                  .tabmenuforuser10,
                                            ),
                                            leading: Image(
                                              image: const AssetImage(
                                                  'assets/images/idea.png'),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return const Payment();
                                                }),
                                              );
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              AppLocalizations.of(context)
                                                  .tabmenuforuser11,
                                            ),
                                            leading: Image(
                                              image: const AssetImage(
                                                  'assets/images/email.png'),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return const NatinfoPages();
                                                }),
                                              );
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              AppLocalizations.of(context)
                                                  .tabmenuforuser12,
                                            ),
                                            leading: Image(
                                              image: const AssetImage(
                                                  'assets/images/logout.png'),
                                            ),
                                            onTap: () {
                                              showConfirmDialog();
                                            },
                                          ),
                                        ],
                                      )),
                                      body: Container(
                                        height: 1000,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/login_bg.png"),
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
                                                    image: AssetImage(
                                                        "assets/images/banner1.jpg"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: SafeArea(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 210,
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        const SizedBox(
                                                          height:
                                                              defaultPadding *
                                                                  1,
                                                        ),
                                                        _Section1(),
                                                        const SizedBox(
                                                          height:
                                                              defaultPadding *
                                                                  1,
                                                        ),
                                                        _Section2(),
                                                        const SizedBox(
                                                          height:
                                                              defaultPadding *
                                                                  1,
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
                                    ),
                                  })
                            })
                  })
        });
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.8;
    return _body;
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
                        child: Text(
                          AppLocalizations.of(context).homeMenu1,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding, bottom: defaultPadding),
                  child: Text(
                    AppLocalizations.of(context).homeMenu1detail,
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
                        child: Text(
                          AppLocalizations.of(context).homeMenu2,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding, bottom: defaultPadding),
                  child: Text(
                    AppLocalizations.of(context).homeMenu2detail,
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
                        child: Text(
                          AppLocalizations.of(context).homeMenu3,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding, bottom: defaultPadding),
                  child: Text(
                    AppLocalizations.of(context).homeMenu3detail,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
