// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/ForeignMemberUpdateProfilePage2Request.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Services/MemberUpdateProfileService.dart';
import 'package:nat/widgets/customConfirmDialog.dart';


class MemberProfileEngPage2 extends StatefulWidget {
  MemberProfileEngPage2(this.memberInfo);
  MemberInfo memberInfo;

  @override
  _MemberProfileEngPage2State createState() => _MemberProfileEngPage2State();
}

class _MemberProfileEngPage2State extends State<MemberProfileEngPage2> {
  final _formKey = GlobalKey<FormState>();
  DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
  MemberInfo memberInfo;
  ForeignMemberUpdateProfilePage2Request foreignMemberUpdateProfilePage2Request;

  TextEditingController addressNOEditor = TextEditingController();

  Future<void> initialWidgetValues(MemberInfo memberInfo) async {
    setState(() {
      foreignMemberUpdateProfilePage2Request =
          ForeignMemberUpdateProfilePage2Request(memberInfo);

      addressNOEditor.text = memberInfo.foreignerAddress;
    });
  }

  Future<void> saveMemberProfile() async {
    MemberUpdateProfileService memberUpdateProfileService =
        MemberUpdateProfileService(WebAPI_Config.mainWebAPIURL);
    var response =
        await memberUpdateProfileService.updateForeignMemberProfilePage2(
            foreignMemberUpdateProfilePage2Request);
    if (response.statusCode == 200) {
      showMessageENDialog(context, "NAT Archives", "Complete").then((result) =>
          {Navigator.of(context).popUntil((route) => route.isFirst)});
    } else {
      String reson = response.reasonPhrase;
      showMessageDialog(context, "", reson);
    }
  }

  @override
  void initState() {
    memberInfo = widget.memberInfo;
    //Wait future method to complte one by one.
    initialWidgetValues(memberInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          margin: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextFormField(
                  controller: addressNOEditor,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    isDense: true, // Added this
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      memberInfo.foreignerAddress = value;
                      foreignMemberUpdateProfilePage2Request.foreignerAddress =
                          value;
                    });
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: defaultPadding * 1.5),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       labelText: 'Mobile NO.',
              //       border: new OutlineInputBorder(
              //         borderRadius: new BorderRadius.circular(10),
              //         borderSide: new BorderSide(),
              //       ),
              //       isDense: true, // Added this
              //       contentPadding: EdgeInsets.all(12),
              //     ),
              //     onChanged: (value) {},
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: defaultPadding * 1.5),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       labelText: 'Fax',
              //       border: new OutlineInputBorder(
              //         borderRadius: new BorderRadius.circular(10),
              //         borderSide: new BorderSide(),
              //       ),
              //       isDense: true, // Added this
              //       contentPadding: EdgeInsets.all(12),
              //     ),
              //     onChanged: (value) {},
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: defaultPadding * 1.5),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       labelText: 'Email',
              //       border: new OutlineInputBorder(
              //         borderRadius: new BorderRadius.circular(10),
              //         borderSide: new BorderSide(),
              //       ),
              //       isDense: true, // Added this
              //       contentPadding: EdgeInsets.all(12),
              //     ),
              //     onChanged: (value) {},
              //   ),
              // ),
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal[600]),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        saveMemberProfile();
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
