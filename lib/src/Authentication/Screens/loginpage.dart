// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/src/Authentication/Screens/loginuser.dart';
import 'package:nat/src/Register/Screens/register.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash_screen.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 170),
            child: _loginSetup(context),
          ),
        ),
      ),
    );
  }

  Widget _loginSetup(BuildContext context) {
    return Container(
      child: Form(
        child: _loginUI(context),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 140),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height / 3.8,
            child: Column(),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.only(
              left: 85,
              right: 85,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0))),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.teal[600]),
                textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.white)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginUser(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        child: Text(
                          AppLocalizations.of(context).menuloginpage,
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Kanit"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height / 3.8,
                  child: Column(),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    left: 85,
                    right: 85,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange[100]),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.black)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child:  Text(
                              AppLocalizations.of(context).menuloginpages,
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "Kanit"),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
