// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';
import 'package:nat/src/Register/Services/MemberRegisterService.dart';
import 'package:nat/src/Register/Models/ShortMemberRegisterRequest.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/utils/memberactivity.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Authentication/Screens/loginuser.dart';
import 'package:nat/validation.dart';
import 'package:nat/widgets/customConfirmDialog.dart';
import 'package:nat/widgets/progress_dialog.dart';

class ShortRegisterAsThaiPage extends StatefulWidget {
  const ShortRegisterAsThaiPage({Key key}) : super(key: key);

  @override
  _ShortRegisterAsThaiPageState createState() =>
      _ShortRegisterAsThaiPageState();
}

class _ShortRegisterAsThaiPageState extends State<ShortRegisterAsThaiPage> {
  final _formKey = GlobalKey<FormState>();
  DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
  MemberActivity memberActivity = MemberActivity(WebAPI_Config.mainWebAPIURL);
  ProgressDialog pr;

  ShortMemberRegisterRequest shortMemberRegisterRequest =
      ShortMemberRegisterRequest();
  TitleName selectedTitleName;
  bool isOtherTitleNameSelected = false;

  List<TitleName> titleNames;
  List<DropdownMenuItem<TitleName>> dorpDownTitleNameItems =
      <DropdownMenuItem<TitleName>>[];

  loadAllMasterData() {}

  additemsToDropdownAndSetDefaultValue() {
    //title name.
    dataProvider.getTitleNames().then((result) {
      setState(() {
        result.sort((a, b) => a.thSorting.compareTo(b.thSorting));
        dorpDownTitleNameItems = result
            .map((d) => DropdownMenuItem(
                  value: d,
                  child: Text(d.titleNameTH),
                ))
            .toList();
        selectedTitleName = dorpDownTitleNameItems.first.value;
      });
    });
  }

  void registerMember() async {
    MemberRegisterService memberRegisterService =
        MemberRegisterService(WebAPI_Config.mainWebAPIURL);

    var response = await memberRegisterService
        .postShortRegisterMember(shortMemberRegisterRequest);
    if (response.statusCode == 200) {
          showMessageDialog(context, "", "สมัครสมาชิกเรียบร้อย").then((value) => {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const LoginUser()))
          });
    }
  }

  @override
  void initState() {
    super.initState();
    loadAllMasterData();
    additemsToDropdownAndSetDefaultValue();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ลงทะเบียน'),
        backgroundColor: Colors.teal[600],
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.only(
                top: defaultPadding,
                right: defaultPadding * 2,
                left: defaultPadding * 2,
                bottom: defaultPadding * 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: Image(image: const AssetImage('assets/images/logo.png'))),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: defaultPadding, top: defaultPadding),
                  child: const Text("หมายเลขประจำตัวประชาชน"),
                ),
                Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(),
                      ),
                      isDense: true, // Added this
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    maxLength: 13,
                    onChanged: (value) {
                      shortMemberRegisterRequest.cardID = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'กรอกเลขบัตรประชาชน';
                      }
                      if (!CustomValidation.isValidPersonCardID(value)) {
                        return 'เลขบัตรประชาชนไม่ถูกต้อง';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: defaultPadding),
                  child: const Text("คำนำหน้าชื่อ"),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.only(
                      left: defaultPadding, right: defaultPadding),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: const Text(
                        'คำนำหน้าชื่อ',
                      ),
                      items: dorpDownTitleNameItems,
                      value: selectedTitleName,
                      onChanged: (value) {
                        setState(() {
                          selectedTitleName = value;
                          isOtherTitleNameSelected =
                              (selectedTitleName.titleID ==
                                  '9999'); //Is title name other selected.
                          shortMemberRegisterRequest.titleNameID =
                              selectedTitleName.titleID;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Visibility(
                  visible: isOtherTitleNameSelected,
                  child: Padding(
                    padding: const EdgeInsets.only(top: defaultPadding),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'คำนำหน้าชื่ออื่นๆ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(),
                        ),
                        isDense: true, // Added this
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      onChanged: (value) {
                        shortMemberRegisterRequest.titleNameOther = value;
                      },
                      validator: (value) {
                        if (value.isEmpty && isOtherTitleNameSelected) {
                          return 'คำนำหน้าชื่ออื่นๆ';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  child: const Text("ชื่อ"),
                ),
                Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      isDense: true, // Added this
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    onChanged: (value) {
                      shortMemberRegisterRequest.firstName = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'ชื่อ';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: defaultPadding, top: defaultPadding * 1.5),
                  child: const Text("นามสกุล"),
                ),
                Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(),
                      ),
                      isDense: true, // Added this
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    onChanged: (value) {
                      shortMemberRegisterRequest.lastName = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'นามสกุล';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: defaultPadding, top: defaultPadding),
                  child: const Text("อีเมล (Email)"),
                ),
                Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(),
                      ),

                      isDense: true, // Added this
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String value) {
                      Pattern pattern =
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value) || value.isEmpty) {
                        return 'กรุณาตรวจสอบข้อมูลอีกครั้ง';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      shortMemberRegisterRequest.email = value;
                    },
                  ),
                ),
                const SizedBox(
                  height: defaultPadding * 1.5,
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal[600]),
                    ),
                    child: const Text('ลงทะเบียน',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        customConfirmDialog(context, 'Confirm',
                                'ยืนยันการลงทะเบียนใช่หรือไม่ ?')
                            .then((result) {
                          if (result == ConfirmAction.ACCEPT) {
                            registerMember();
                          }
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: defaultPadding * 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
