// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Authentication/Screens/loginuser.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/src/Infomation/Screens/aboutus.dart';
import 'package:nat/src/Infomation/Screens/natinfo.dart';
import 'package:nat/src/Member/Screens/ForeignMember/launcher_foreign.dart';
import 'package:nat/src/MemberOrder/Screens/InBasketOrder.dart';
import 'package:nat/src/MemberOrder/Screens/listapproved.dart';
import 'package:nat/src/MemberOrder/Screens/member_approvedorder.dart';
import 'package:nat/src/MemberOrder/Screens/memberwaitingforapprovalorder.dart';
import 'package:nat/src/MemberOrder/Screens/payment.dart';
import 'package:nat/src/MemberProfile/Models/MemberPhoto.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Screens/MemberProfileEng/memberprofileengpage1.dart';
import 'package:nat/src/MemberProfile/Screens/MemberProfileThai/memberprofilethpage1.dart';
import 'package:nat/src/MemberProfile/Services/MemberProfileService.dart';
import 'package:nat/utils/apphelper.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/utils/memberactivity.dart';
import 'package:nat/src/Searching/Screens/searcher.dart';
import 'package:nat/widgets/customdialog.dart';

class MainForeignpage extends StatefulWidget {
  const MainForeignpage({Key key}) : super(key: key);

  @override
  State<MainForeignpage> createState() => _MainForeignpageState();
}

class _MainForeignpageState extends State<MainForeignpage> {
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginUser(),
        ));
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
                                        title: const Text('Home'),
                                        backgroundColor: Colors.teal[600],
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
                                                Text(
                                                    (memberInfo != null) ? memberInfo.displayName : ''),
                                                Text(
                                                    (memberInfo != null) ? memberInfo.cardID : '')
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Main',
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
                                                        LauncherForeignMember(
                                                            memberInfo),
                                                  ));
                                            },
                                          ),
                                          ListTile(
                                            title: Text('Searcher'),
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
                                            title: const Text('InBasketOrder'),
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
                                                'Copy request information'),
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
                                              title: Row(children: const <Widget>[
                                                Text('In process'),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
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
                                                children: const <Widget>[
                                                  Text('Complete'),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
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
                                                  'Transaction history'),
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
                                            title:
                                                const Text('Member information'),
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
                                            title: const Text(
                                                'About the National Archives'),
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
                                                'Request service for copying documents'),
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
                                            title:
                                                Text('Contact information'),
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
                                            title: Text('Log out'),
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
                        child: const Text(
                          "Contact information",
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
                    'Contact details for the 10 central and provincial national archives',
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
                          "About the National Archives",
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
                    'Introduce the rules, procedures, processes of using the service of the archival document service system for the people.',
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
                          "Request service for copying documents",
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
                    'Introduce the online request for a copy of the National Archives.',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
