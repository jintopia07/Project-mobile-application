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
import 'package:nat/widgets/customdialog.dart';
import 'package:nat/widgets/progress_dialog.dart';

class ShortRegisterAsForeignPage extends StatefulWidget {
  const ShortRegisterAsForeignPage({Key key}) : super(key: key);

  @override
  _ShortRegisterAsForeignPageState createState() =>
      _ShortRegisterAsForeignPageState();
}

class _ShortRegisterAsForeignPageState
    extends State<ShortRegisterAsForeignPage> {
  final _formKey = GlobalKey<FormState>();
  DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
  MemberActivity memberActivity = MemberActivity(WebAPI_Config.mainWebAPIURL);
  ProgressDialog pr;
  ShortMemberRegisterRequest shortMemberRegisterRequest =
      ShortMemberRegisterRequest();

  List<TitleName> titleNames = <TitleName>[];
  TitleName selectedTitleName = TitleName();
  bool isOtherTitleNameSelected = false;
  List<Nationality> nationalities = <Nationality>[];
  Nationality selectedNationality = Nationality();
  bool isOtherNationalitySelected = false;
  List<DropdownMenuItem<TitleName>> dorpDownTitleNameItems =
      <DropdownMenuItem<TitleName>>[];
  List<DropdownMenuItem<Nationality>> dropDownNatinalityItems =
      <DropdownMenuItem<Nationality>>[];

  loadAllMasterData() {}

  additemsToDropdownAndSetDefaultValue() {
    dataProvider.getTitleNames().then((t) {
      setState(() {
        t.sort((a, b) => a.engSorting.compareTo(b.engSorting));
        dorpDownTitleNameItems = t
            .map((tt) => DropdownMenuItem(
                  value: tt,
                  child: Text(tt.titleNameENG),
                ))
            .toList();
        if (dorpDownTitleNameItems.first != null) {
          selectedTitleName = dorpDownTitleNameItems.first.value;
        }
      });
    });

    dataProvider.getNationalities().then((n) {
      setState(() {
        n.removeWhere((item) => item.nationalityNameENG == 'Thai');
        n.sort((a, b) => a.engSorting.compareTo(b.engSorting));
        dropDownNatinalityItems = n
            .map((nt) =>
                DropdownMenuItem(value: nt, child: Text(nt.nationalityNameENG)))
            .toList();
        if (dropDownNatinalityItems.first != null) {
          selectedNationality = dropDownNatinalityItems.first.value;
        }
      });
    });
  }

  void registerMember() async {
    MemberRegisterService memberRegisterService =
        MemberRegisterService(WebAPI_Config.mainWebAPIURL);

    var response = await memberRegisterService
        .postShortRegisterMember(shortMemberRegisterRequest);

    if (response.statusCode == 200) {
      showMessageDialog(context, "", "Register successfully.").then((value) => {
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
        title: const Text("Register"),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(
              top: defaultPadding,
              right: defaultPadding * 1.5,
              left: defaultPadding * 1.5,
              bottom: defaultPadding * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: defaultPadding),
                child: Image(image: const AssetImage('assets/images/logo.png')),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(
                    left: defaultPadding, right: defaultPadding),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: const Text('Natinality'),
                      value: selectedNationality,
                      items: dropDownNatinalityItems,
                      onChanged: (value) {
                        setState(() {
                          selectedNationality = value;
                          isOtherNationalitySelected =
                              (selectedNationality.natinalityID == '9999');
                          shortMemberRegisterRequest.nationalityID =
                              selectedNationality.natinalityID;
                        });
                      },
                    )),
              ),
              const SizedBox(height: defaultPadding),
              Visibility(
                visible: isOtherNationalitySelected,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      labelText: 'Other nationality',
                    ),
                    onChanged: (value) {
                      setState(() {
                        shortMemberRegisterRequest.nationalityOther = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty && isOtherNationalitySelected) {
                        return 'Other nationality';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'PassportID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      shortMemberRegisterRequest.cardID = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'PassportID';
                    }
                    if (!CustomValidation.isPassportValid(value)) {
                      return 'Password ID is not correct.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(
                    left: defaultPadding, right: defaultPadding),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: const Text(
                        'Title name',
                      ),
                      items: dorpDownTitleNameItems,
                      value: selectedTitleName,
                      onChanged: (value) {
                        setState(() {
                          selectedTitleName = value;
                          isOtherTitleNameSelected =
                              (selectedTitleName.titleID == '9999');
                          shortMemberRegisterRequest.titleNameID =
                              selectedTitleName.titleID;
                        });
                      },
                    )),
              ),
              Visibility(
                visible: isOtherTitleNameSelected,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Title name other',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        shortMemberRegisterRequest.titleNameOther = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty && isOtherTitleNameSelected) {
                        return 'Title name other';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      shortMemberRegisterRequest.firstName = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      shortMemberRegisterRequest.lastName = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Last name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      shortMemberRegisterRequest.email = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
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
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      customConfirmDialog(context, 'Confirm',
                              'Do you confrim to register ?')
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
                height: defaultPadding * 1.5,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
