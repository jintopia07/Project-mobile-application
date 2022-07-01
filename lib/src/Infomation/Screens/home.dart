// @dart=2.9
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Infomation/Screens/aboutus.dart';
import 'package:nat/src/Infomation/Screens/natinfo.dart';
import 'package:nat/src/MemberOrder/Screens/payment.dart';
import 'package:nat/widgets/category_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  static const routeName = '/home';
  

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          body: SafeArea(
            child: Container(
              height: 1000,
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
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 210, left: 20, right: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            NATInfo_Section(),
                            const SizedBox(
                              height: 20,
                            ),
                            AboutUs_Section(),
                            const SizedBox(
                              height: 20,
                            ),
                            Payment_Section(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget NATInfo_Section() => Container(
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
                  margin: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                  ),
                  padding: const EdgeInsets.only(top: defaultPadding),
                  alignment: FractionalOffset.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/maps.png",
                        width: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context).homeMenu1,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding,
                      bottom: defaultPadding * 1,
                      right: defaultPadding,
                      top: defaultPadding * 0.5),
                  child: Text(
                    AppLocalizations.of(context).homeMenu1detail,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget AboutUs_Section() => Container(
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
                  margin: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                  ),
                  padding: const EdgeInsets.only(top: defaultPadding),
                  alignment: FractionalOffset.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/help.png",
                        width: 30,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: defaultPadding * 0.8),
                        child: Text(
                          AppLocalizations.of(context).homeMenu2,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding,
                      bottom: defaultPadding * 1,
                      right: defaultPadding,
                      top: defaultPadding * 0.5),
                  child: Text(
                    AppLocalizations.of(context).homeMenu2detail,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget Payment_Section() => Container(
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
                  margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 1),
                  padding: const EdgeInsets.only(top: defaultPadding),
                  alignment: FractionalOffset.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/list.png",
                        width: 50,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: defaultPadding * 0.1),
                        child: Text(
                          AppLocalizations.of(context).homeMenu3,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding,
                      bottom: defaultPadding * 1,
                      right: defaultPadding),
                  child: Text(
                    AppLocalizations.of(context).homeMenu3detail,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
