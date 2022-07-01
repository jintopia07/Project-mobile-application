// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NatinfoPages extends StatefulWidget {
  const NatinfoPages({Key key}) : super(key: key);

  @override
  _NatinfoPagesState createState() => _NatinfoPagesState();
}

class _NatinfoPagesState extends State<NatinfoPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).titlenatinfo,
        ),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding * 1.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                   AppLocalizations.of(context).headinforegional,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Section1(),
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
              Section2(),
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
              Section3(),
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
              Section4(),
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
              Section5(),
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
              Section6(),
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
              Section7(),
              const SizedBox(height: defaultPadding * 1.5),
              Section8(),
              const SizedBox(height: defaultPadding * 1.5),
              Section9(),
              const SizedBox(height: defaultPadding * 1.5),
              Section10(),
              const SizedBox(height: defaultPadding * 1.5),
              Section11(),
              const SizedBox(
                height: defaultPadding * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Section1() => Container(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1,
              ),
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding * 1.5),
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/NATPratum.png",
                    width: double.infinity,
                    height: 150,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                      AppLocalizations.of(context).inforegional1,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionaladd,
                      style: TextStyle(color: (Colors.redAccent[400])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionaldetail1,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                           AppLocalizations.of(context).inforegionalphone,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "0 2902 7948",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalfax,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            " 0 2902 7941",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    padding: const EdgeInsets.only(top: defaultPadding),
                    alignment: FractionalOffset.topCenter,
                    child: InkWell(
                      onTap: () {
                        const url =
                            'https://www.google.co.th/maps/place/National+Archives/@14.0712625,100.7042529,17z/data=!3m1!4b1!4m5!3m4!1s0x311d818b24944f83:0xb17c9ebacc1e05c0!8m2!3d14.0712625!4d100.7064416';
                        launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/maps.png",
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultPadding * 0.8),
                            child: Text(
                               AppLocalizations.of(context).inforegionalmap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget Section2() => Container(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding * 1),
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/NATCheangMai.png",
                    width: double.infinity,
                    height: 150,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                      AppLocalizations.of(context).inforegional2,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                       AppLocalizations.of(context).inforegionalarea,
                      style: TextStyle(color: (Colors.redAccent[400])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionalareadetail1,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).inforegionaladd,
                    style: TextStyle(color: (Colors.redAccent[400])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionaldetail2,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalphone,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "0 5328 1425",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalfax,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            " 0 5328 1424",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    padding: const EdgeInsets.only(top: defaultPadding),
                    alignment: FractionalOffset.topCenter,
                    child: InkWell(
                      onTap: () {
                        const url =
                            'https://www.google.co.th/maps/place/Anniversary+Archives+of+Thailand/@18.7887344,98.9751756,17z/data=!3m1!4b1!4m5!3m4!1s0x30da3a848b3dcd7b:0xb4143c0d95f92944!8m2!3d18.7887344!4d98.9773643';
                        launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/maps.png",
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultPadding * 0.8),
                            child: Text(
                              AppLocalizations.of(context).inforegionalmap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget Section3() => Container(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding * 1),
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/NATTrung.jpg",
                    width: double.infinity,
                    height: 150,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                     AppLocalizations.of(context).inforegional3,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionalarea,
                      style: TextStyle(color: (Colors.redAccent[400])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionalareadetail3,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).inforegionaladd,
                    style: TextStyle(color: (Colors.redAccent[400])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionaldetail3,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalphone,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "0 7521 2504",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalfax,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            " 0 7521 4045",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    padding: const EdgeInsets.only(top: defaultPadding),
                    alignment: FractionalOffset.topCenter,
                    child: InkWell(
                      onTap: () {
                        const url = 'https://goo.gl/maps/Ds9k8R6W7zNSUtpu7';
                        launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/maps.png",
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultPadding * 0.8),
                            child: Text(
                             AppLocalizations.of(context).inforegionalmap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget Section4() => Container(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding * 1),
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/NATYala.jpg",
                    width: double.infinity,
                    height: 150,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                      AppLocalizations.of(context).inforegional4,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                     AppLocalizations.of(context).inforegionalarea,
                      style: TextStyle(color: (Colors.redAccent[400])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionalareadetail4,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).inforegionaladd,
                    style: TextStyle(color: (Colors.redAccent[400])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                     AppLocalizations.of(context).inforegionaldetail4,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalphone,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "0 7321 6667",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalfax,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            " 0 7321 6667",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalemail,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "na_yala@finearts.go.th",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: defaultPadding * 0.5),
                      child: const Text(
                        "yala_archives@hotmail.com",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget Section5() => Container(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding * 1),
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/NATSongkla.png",
                    width: double.infinity,
                    height: 150,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                     AppLocalizations.of(context).inforegional5,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                       AppLocalizations.of(context).inforegionalarea,
                      style: TextStyle(color: (Colors.redAccent[400])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionalareadetail5,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).inforegionaladd,
                    style: TextStyle(color: (Colors.redAccent[400])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionaldetail5,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalphone,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "0 7421 2479",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalfax,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            " 0 7421 2182",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    padding: const EdgeInsets.only(top: defaultPadding),
                    alignment: FractionalOffset.topCenter,
                    child: InkWell(
                      onTap: () {
                        const url = 'https://goo.gl/maps/P3ZL3iftPxuMyNm96';
                        launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/maps.png",
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultPadding * 0.8),
                            child: Text(
                              AppLocalizations.of(context).inforegionalmap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget Section6() => Container(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding * 1),
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/NATPayao.jpg",
                    width: double.infinity,
                    height: 150,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                     AppLocalizations.of(context).inforegional6,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionalarea,
                      style: TextStyle(color: (Colors.redAccent[400])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding * 0.5, bottom: defaultPadding),
                    child: Text(
                      AppLocalizations.of(context).inforegionalareadetail6,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).inforegionaladd,
                    style: TextStyle(color: (Colors.redAccent[400])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionaldetail6,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalphone,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "0 5441 1051",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalfax,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            " 0 5441 1052",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    padding: const EdgeInsets.only(top: defaultPadding),
                    alignment: FractionalOffset.topCenter,
                    child: InkWell(
                      onTap: () {
                        const url = 'https://goo.gl/maps/pMBtGwzQZsgNDuB79';
                        launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/maps.png",
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultPadding * 0.8),
                            child: Text(
                              AppLocalizations.of(context).inforegionalmap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget Section7() => Container(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding * 1),
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/NATUbon.JPG",
                    width: double.infinity,
                    height: 150,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                     AppLocalizations.of(context).inforegional7,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionalarea,
                      style: TextStyle(color: (Colors.redAccent[400])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding * 0.5, bottom: defaultPadding),
                    child: Text(
                      AppLocalizations.of(context).inforegionalareadetail7,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).inforegionaladd,
                    style: TextStyle(color: (Colors.redAccent[400])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionaldetail7,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalphone,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "0 4528 5522",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalfax,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            " 0 4528 5523",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    padding: const EdgeInsets.only(top: defaultPadding),
                    alignment: FractionalOffset.topCenter,
                    child: InkWell(
                      onTap: () {
                        const url = 'https://goo.gl/maps/vhUK7ioinYB83o1t9';
                        launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/maps.png",
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultPadding * 0.8),
                            child: Text(
                             AppLocalizations.of(context).inforegionalmap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget Section8() => Container(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding * 1),
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/NATSuparn.jpg",
                    width: double.infinity,
                    height: 150,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                     AppLocalizations.of(context).inforegional8,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionalarea,
                      style: TextStyle(color: (Colors.redAccent[400])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding * 0.5, bottom: defaultPadding),
                    child: Text(
                      AppLocalizations.of(context).inforegionalareadetail8,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).inforegionaladd,
                    style: TextStyle(color: (Colors.redAccent[400])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionaldetail8,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalphone,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "0 3553 5501",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalfax,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            " 0 3553 5502",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    padding: const EdgeInsets.only(top: defaultPadding),
                    alignment: FractionalOffset.topCenter,
                    child: InkWell(
                      onTap: () {
                        const url = 'https://goo.gl/maps/KUUZ3tbDyY4LZBiv6';
                        launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/maps.png",
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultPadding * 0.8),
                            child: Text(
                              AppLocalizations.of(context).inforegionalmap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget Section9() => Container(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding * 1),
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/NATJantaburi.jpg",
                    width: double.infinity,
                    height: 150,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                      AppLocalizations.of(context).inforegional9,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionalarea,
                      style: TextStyle(color: (Colors.redAccent[400])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding * 0.5, bottom: defaultPadding),
                    child: Text(
                      AppLocalizations.of(context).inforegionalareadetail9,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).inforegionaladd,
                    style: TextStyle(color: (Colors.redAccent[400])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionaldetail9,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalphone,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "0 3932 4685",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                         AppLocalizations.of(context).inforegionalfax,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            " 0 3932 4685",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    padding: const EdgeInsets.only(top: defaultPadding),
                    alignment: FractionalOffset.topCenter,
                    child: InkWell(
                      onTap: () {
                        const url = 'https://goo.gl/maps/HfvabfL9GPycW2q1A';
                        launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/maps.png",
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultPadding * 0.8),
                            child: Text(
                              AppLocalizations.of(context).inforegionalmap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget Section10() => Container(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding * 1),
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/NATNakhonSiThammarat.png",
                    width: double.infinity,
                    height: 150,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                     AppLocalizations.of(context).inforegional10,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                       AppLocalizations.of(context).inforegionalarea,
                      style: TextStyle(color: (Colors.redAccent[400])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding * 0.5, bottom: defaultPadding),
                    child: Text(
                       AppLocalizations.of(context).inforegionalareadetail10,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).inforegionaladd,
                    style: TextStyle(color: (Colors.redAccent[400])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionaldetail10,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalphone,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "0 7534 2015",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalfax,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            " 0 7534 2105",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    padding: const EdgeInsets.only(top: defaultPadding),
                    alignment: FractionalOffset.topCenter,
                    child: InkWell(
                      onTap: () {
                        const url = 'https://goo.gl/maps/jXDinJ1MczpMnFBs7';
                        launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/maps.png",
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultPadding * 0.8),
                            child: Text(
                              AppLocalizations.of(context).inforegionalmap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget Section11() => Container(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
              ),
              padding: const EdgeInsets.only(
                  top: defaultPadding, bottom: defaultPadding * 1),
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/NATBanhan.png",
                    width: double.infinity,
                    height: 150,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                     AppLocalizations.of(context).inforegional11,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionalarea,
                      style: TextStyle(color: (Colors.redAccent[400])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding * 0.5, bottom: defaultPadding),
                    child: Text(
                     AppLocalizations.of(context).inforegionalareadetail11,
                    ),
                  ),
                  Text(
                   AppLocalizations.of(context).inforegionaladd,
                    style: TextStyle(color: (Colors.redAccent[400])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: defaultPadding * 1, top: defaultPadding * 0.5),
                    child: Text(
                      AppLocalizations.of(context).inforegionaldetail11,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalphone,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            "0 3553 5119-21",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).inforegionalfax,
                          style: TextStyle(color: (Colors.redAccent[400])),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 0.8),
                          child: const Text(
                            " 0 3553 5119-21",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                    ),
                    padding: const EdgeInsets.only(top: defaultPadding),
                    alignment: FractionalOffset.topCenter,
                    child: InkWell(
                      onTap: () {
                        const url = 'https://goo.gl/maps/YVfKPfuBsiyysTtS9';
                        launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/maps.png",
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultPadding * 0.8),
                            child: Text(
                              AppLocalizations.of(context).inforegionalmap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
