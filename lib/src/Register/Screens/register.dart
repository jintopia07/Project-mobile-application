// @dart=2.9
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nat/src/Register/Screens/shortregisterasforeignpage.dart';
import 'package:nat/src/Register/Screens/shortregisterasthaipage.dart';
import 'package:nat/utils/form_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).menuregister),
          backgroundColor: Colors.teal[600],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: _registerUI(context),
          ),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height / 3.8,
          child: Column(),
        ),
        Container(
          margin: const EdgeInsets.only(left: 125, right: 125),
          height: 120,
          width: 120,
          child: Image.asset("assets/images/logo.png"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: const Text(
            'ระบบบริการเอกสารจดหมายเหตุเพื่อประชาชน',
            style: TextStyle(fontSize: 15),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(AppLocalizations.of(context).menuregisterpage ,  style: TextStyle(fontSize: 14),),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          child: FormHelper.saveButton(
            "ชาวไทย / Thai",
            () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const ShortRegisterAsThaiPage();
                },
              ));
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
         Container(
          child: FormHelper.saveButton( 
            "ชาวต่างชาติ / Foreigner",
            () {
               Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const ShortRegisterAsForeignPage();
                  },
                ));
            },
          ),
        ),
       
      ],
    );
  }
}
