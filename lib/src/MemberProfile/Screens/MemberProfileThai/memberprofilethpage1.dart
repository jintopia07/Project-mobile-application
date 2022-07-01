// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/THMemberUpdateProfilePage1Request.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Services/MemberProfileService.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/MemberProfile/Services/MemberUpdateProfileService.dart';
import 'package:nat/utils/DateHelper.dart';
import 'package:nat/widgets/customConfirmDialog.dart';

class MemberProfileTHPage1 extends StatefulWidget {
  MemberProfileTHPage1(this.memberInfo);
  MemberInfo memberInfo;

  @override
  _MemberProfileTHPage1State createState() => _MemberProfileTHPage1State();
}

class _MemberProfileTHPage1State extends State<MemberProfileTHPage1> {
  final _formKey = GlobalKey<FormState>();
  DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
  MemberInfo memberInfo;
  THMemberUpdateProfilePage1Request thMemberUpdateProfilePage1Request;

  //master data's properties.
  List<TitleName> titleNames = <TitleName>[];
  List<Religion> religions = <Religion>[];
  List<Nationality> nationalities = <Nationality>[];
  List<Race> races = <Race>[];

  //Widget's properties.
  List<DropdownMenuItem> dropdownTitleNameItems;
  TitleName selectedTitleName;
  bool isTitleNameOtherSelected = false;
  TextEditingController titleNameOtherTextEditor = TextEditingController();

  TextEditingController nameTextEditor = TextEditingController();
  TextEditingController lastNameTextEditor = TextEditingController();
  int _selectedGenderValue = 1;
  DateTime _selectedBirthDate;
  TextEditingController birthDateEditor = TextEditingController();

  List<DropdownMenuItem> dropdownReligionItems;
  Religion selectedReligion;
  bool isReligionOtherSelected = false;
  TextEditingController otherReligionEditor = TextEditingController();

  List<DropdownMenuItem> dropdownNationalityItems;
  Nationality selectedNationality;
  bool isNationaltityOtherSelected = false;
  TextEditingController otherNationalityEditor = TextEditingController();

  List<DropdownMenuItem> dropdownRaceItems;
  Race selectedRace;
  bool isRaceOtherSelected = false;
  TextEditingController raceOtherEditor = TextEditingController();

  TextEditingController cardIDTextEditor = TextEditingController();
  DateTime _selectedCardIssueDate;
  TextEditingController cardIssueDateEditor = TextEditingController();
  DateTime _selectedCardExpireDate;
  TextEditingController cardExpiredDateEditor = TextEditingController();
  TextEditingController cardIssuedPlaceTextEditor = TextEditingController();
  TextEditingController phoneNoEditor = TextEditingController();
  TextEditingController EmailEditor = TextEditingController();

  Future<void> loadMasterdata() async {
    //Get title name.
    await dataProvider.getTitleNames().then((t) {
      setState(() {
        t.sort((a, b) => a.thSorting.compareTo(b.thSorting));
        titleNames = t;
      });
    });
    //Get religion name.
    await dataProvider.getReligions().then((r) {
      setState(() {
        r.sort((a, b) => a.thSorting.compareTo(b.thSorting));
        religions = r;
      });
    });
    //Get nationality.
    await dataProvider.getNationalities().then((n) {
      setState(() {
        n.sort((a, b) => a.thSorting.compareTo(b.thSorting));
        nationalities = n;
      });
    });
    //Get races.
    await dataProvider.getRaces().then((r) {
      setState(() {
        r.sort((a, b) => a.thSorting.compareTo(b.thSorting));
        races = r;
      });
    });
  }

  Future<void> setWidgetsProperites() async {
    setState(() {
      //Title name.
      // selectedTitleName = titleNames.first;
      dropdownTitleNameItems = titleNames
          .map((t) => DropdownMenuItem(
                value: t,
                child: Text(t.titleNameTH),
              ))
          .toList();
      //Religions.
      dropdownReligionItems = religions
          .map((r) => DropdownMenuItem(
                value: r,
                child: Text(r.religionNameTH),
              ))
          .toList();
      //Nationality
      dropdownNationalityItems = nationalities
          .map((n) => DropdownMenuItem(
                value: n,
                child: Text(n.nationalityNameTH),
              ))
          .toList();
      //Race
      dropdownRaceItems = races
          .map((r) => DropdownMenuItem(
                value: r,
                child: Text(r.raceNameTH),
              ))
          .toList();
    });
    //Title name.
  }

  Future<void> initialWidgetValues(MemberInfo memberObj) async {
    setState(() {
      thMemberUpdateProfilePage1Request =
          THMemberUpdateProfilePage1Request(memberObj);

      if (memberObj.titleName != null) {
        TitleName getTitleName = titleNames
            .firstWhere((t) => t.titleID == memberInfo.titleName.titleID);

        if (getTitleName != null) {
          selectedTitleName = getTitleName;
          isTitleNameOtherSelected = (getTitleName.titleID == '9999');
        }
      }
      titleNameOtherTextEditor.text = memberObj.titleNameOther;
      nameTextEditor.text = memberObj.firstName;
      lastNameTextEditor.text = memberObj.lastName;
      _selectedGenderValue = memberObj.gender;
      if (memberObj.birthDate != null) {
        _selectedBirthDate = memberObj.birthDate;
        birthDateEditor.text =
            DateHelper.ConvertDateTimeToDefaultFormatDate(memberObj.birthDate);
      }
      if (memberObj.religion != null) {
        Religion getReligion = religions
            .firstWhere((r) => r.religionID == memberObj.religion.religionID);
        if (getReligion != null) {
          selectedReligion = getReligion;
          isReligionOtherSelected = (getReligion.religionID == '9999');
        }
      }
      if (memberObj.nationality != null) {
        Nationality getNationality = nationalities.firstWhere(
            (n) => n.natinalityID == memberObj.nationality.natinalityID);
        if (getNationality != null) {
          selectedNationality = getNationality;
          isNationaltityOtherSelected = (getNationality.natinalityID == '9999');
        }
      }
      if (memberObj.race != null) {
        Race getRace =
            races.firstWhere((r) => r.raceID == memberObj.race.raceID);
        if (getRace != null) {
          selectedRace = getRace;
          isRaceOtherSelected = (getRace.raceID == '9999');
        }
      }

      cardIDTextEditor.text = memberObj.cardID;
      if (memberObj.cardIssueDate != null) {
        _selectedCardIssueDate = memberObj.cardIssueDate;
        cardIssueDateEditor.text =
            DateHelper.ConvertDateTimeToDefaultFormatDate(
                memberObj.cardIssueDate);
      }
      if (memberObj.cardExpireDate != null) {
        _selectedCardExpireDate = memberObj.cardExpireDate;
        cardExpiredDateEditor.text =
            DateHelper.ConvertDateTimeToDefaultFormatDate(
                memberObj.cardExpireDate);
      }
      cardIssuedPlaceTextEditor.text = memberObj.cardIssuePlace;

      phoneNoEditor.text = memberObj.mobileNO;
      EmailEditor.text = memberObj.email;
    });
  }

  saveMembrProfile() async {
    MemberUpdateProfileService memberUpdateProfileService =
        MemberUpdateProfileService(WebAPI_Config.mainWebAPIURL);
    var response = await memberUpdateProfileService
        .updateTHMemberProfilePage1(thMemberUpdateProfilePage1Request);
    if (response.statusCode == 200) {
      showMessageDialog(context, "NAT Archives", "บันทึกข้อมูลเรียบร้อย").then(
          (result) =>
              {Navigator.of(context).popUntil((route) => route.isFirst)});
    } else {
      String reson = response.reasonPhrase;
      showMessageDialog(context, "", reson);
    }
  }

  @override
  void initState() {
    super.initState();
    memberInfo = widget.memberInfo;
    //Wait future method to complte one by one.
    Future.wait([loadMasterdata()]).whenComplete(() {
      Future.wait([setWidgetsProperites()]).whenComplete(() {
        Future.wait([initialWidgetValues(memberInfo)]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ข้อมูลผู้ใช้งาน'),
          backgroundColor: Colors.teal[600],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            margin: const EdgeInsets.all(defaultPadding),
            child: Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.only(
                      top: defaultPadding,
                      right: defaultPadding * 0.5,
                      left: defaultPadding * 0.5,
                      bottom: defaultPadding * 1.5),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(
                            left: defaultPadding, right: defaultPadding),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              underline: const SizedBox(),
                              hint: const Text('คำนำหน้าชื่อ'),
                              isExpanded: true,
                              value: selectedTitleName,
                              items: dropdownTitleNameItems,
                              onChanged: (value) {
                                setState(() {
                                  selectedTitleName = value;
                                  memberInfo.titleName = selectedTitleName;
                                  thMemberUpdateProfilePage1Request.titleID =
                                      selectedTitleName.titleID;
                                  isTitleNameOtherSelected =
                                      (selectedTitleName.titleID == '9999');
                                });
                              },
                              // validator: (value) {
                              //   if (value == null && selectedTitleName == null) {
                              //     return 'กรุณาเลือก คำนำหน้าชื่อ';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Visibility(
                        visible: isTitleNameOtherSelected,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            controller: titleNameOtherTextEditor,
                            decoration: InputDecoration(
                              labelText: 'ระบุคำนำหน้าชื่ออื่นๆ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                memberInfo.titleNameOther = value;
                                thMemberUpdateProfilePage1Request
                                    .titleNameOther = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty && isTitleNameOtherSelected) {
                                return 'กรอกคำนำหน้าชื่ออื่นๆ';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: defaultPadding),
                        child: TextFormField(
                          controller: nameTextEditor,
                          decoration: InputDecoration(
                            labelText: 'ชื่อ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(),
                            ),
                            isDense: true, // Added this
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          onChanged: (value) {
                            setState(() {
                              memberInfo.firstName = value;
                              thMemberUpdateProfilePage1Request.firstName =
                                  value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'กรอกชื่อ';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: defaultPadding * 1.5),
                        child: TextFormField(
                          controller: lastNameTextEditor,
                          decoration: InputDecoration(
                            labelText: 'นามสกุล',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            isDense: true, // Added this
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          onChanged: (value) {
                            setState(() {
                              memberInfo.lastName = value;
                              thMemberUpdateProfilePage1Request.lastName =
                                  value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'กรอกนามสกุล';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: defaultPadding * 0.5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: ListTile(
                                title: const Text('ชาย'),
                                leading: Radio(
                                  groupValue: _selectedGenderValue,
                                  value: 1,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGenderValue = value;
                                      memberInfo.gender = value;
                                      thMemberUpdateProfilePage1Request.gender =
                                          value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: ListTile(
                                title: const Text('หญิง'),
                                leading: Radio(
                                  groupValue: _selectedGenderValue,
                                  value: 2,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGenderValue = value;
                                      memberInfo.gender = value;
                                      thMemberUpdateProfilePage1Request.gender =
                                          value;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: defaultPadding),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: IgnorePointer(
                                child: TextFormField(
                                  controller: birthDateEditor,
                                  decoration: InputDecoration(
                                    labelText: 'วันเกิด',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      borderSide: BorderSide(),
                                    ),
                                    isDense: true, // Added this
                                    contentPadding: const EdgeInsets.all(12),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.date_range),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2500),
                                        initialDate: DateTime.now())
                                    .then((selectedDate) => {
                                          thMemberUpdateProfilePage1Request
                                              .birthDate = selectedDate,
                                          birthDateEditor.text = DateHelper
                                              .ConvertDateTimeToDefaultFormatDate(
                                                  selectedDate)
                                        });
                              },
                            )
                          ],
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
                          padding: const EdgeInsets.only(
                              left: defaultPadding, right: defaultPadding),
                          child: Container(
                            child: DropdownButtonFormField(
                              hint: const Text('ศาสนา'),
                              isExpanded: true,
                              value: selectedReligion,
                              items: dropdownReligionItems,
                              onChanged: (value) {
                                setState(() {
                                  selectedReligion = value;
                                  memberInfo.religion = value;
                                  thMemberUpdateProfilePage1Request.religionID =
                                      selectedReligion.religionID;
                                  isReligionOtherSelected =
                                      (selectedReligion.religionID == '9999');
                                });
                              },
                              validator: (value) {
                                if (value == null && selectedReligion == null) {
                                  return 'ศาสนา';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding * 1.5,
                      ),
                      Visibility(
                        visible: isReligionOtherSelected,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: defaultPadding, top: defaultPadding),
                          child: TextFormField(
                            controller: otherReligionEditor,
                            decoration: InputDecoration(
                              labelText: 'ระบุศาสนา',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                memberInfo.religionOther = value;
                                thMemberUpdateProfilePage1Request
                                    .religionOther = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty && isReligionOtherSelected) {
                                return 'ระบุศาสนา';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 0.5),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(
                            left: defaultPadding, right: defaultPadding),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: DropdownButtonFormField(
                            hint: const Text('เชื้อชาติ'),
                            isExpanded: true,
                            value: selectedNationality,
                            items: dropdownNationalityItems,
                            onChanged: (value) {
                              setState(() {
                                selectedNationality = value;
                                memberInfo.nationality = value;
                                thMemberUpdateProfilePage1Request
                                        .nationalityID =
                                    selectedNationality.natinalityID;
                                isNationaltityOtherSelected =
                                    (selectedNationality.natinalityID ==
                                        '9999');
                              });
                            },
                            validator: (value) {
                              if (value == null &&
                                  selectedNationality == null) {
                                return 'เชื้อชาติ';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding * 1.5,
                      ),
                      Visibility(
                        visible: isNationaltityOtherSelected,
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: TextFormField(
                            controller: otherNationalityEditor,
                            decoration: InputDecoration(
                              labelText: 'ระบบเชื้อชาติ อื่นๆ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                memberInfo.nationalityother = value;
                                thMemberUpdateProfilePage1Request
                                    .nationalityOther = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty &&
                                  isNationaltityOtherSelected) {
                                return 'ระบุเชื้อชาติ';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(
                            left: defaultPadding, right: defaultPadding),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              hint: const Text('สัญชาติ'),
                              isExpanded: true,
                              value: selectedRace,
                              items: dropdownRaceItems,
                              onChanged: (value) {
                                setState(() {
                                  selectedRace = value;
                                  memberInfo.race = value;
                                  thMemberUpdateProfilePage1Request.raceID =
                                      selectedRace.raceID;
                                  isRaceOtherSelected =
                                      (selectedRace.raceID == '9999');
                                });
                              },
                              validator: (value) {
                                if (value == null && selectedRace == null) {
                                  return 'สัญชาติ';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 1.5),
                      Visibility(
                        visible: isRaceOtherSelected,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: defaultPadding),
                          child: TextFormField(
                            controller: raceOtherEditor,
                            decoration: InputDecoration(
                              labelText: 'ระบุสัญชาติ อื่นๆ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                memberInfo.raceOther = value;
                                thMemberUpdateProfilePage1Request.raceOther =
                                    value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty && isRaceOtherSelected) {
                                return 'ระบุสัญชาติ อื่นๆ';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: defaultPadding),
                        child: TextFormField(
                          controller: cardIDTextEditor,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'หมายเลขบัตรประจำตัว',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            isDense: true, // Added this
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          onChanged: (value) {
                            memberInfo.cardID = value;
                            thMemberUpdateProfilePage1Request.cardID = value;
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: defaultPadding * 1.5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: IgnorePointer(
                              ignoring: true,
                              child: TextFormField(
                                enabled: true,
                                controller: cardIssueDateEditor,
                                decoration: InputDecoration(
                                  labelText: 'วันที่ออกบัตรประชาชน',
                                  hintText: 'เลือกวันที่ออกบัตรประชาชน',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(),
                                  ),
                                  isDense: true, // Added this
                                  contentPadding: const EdgeInsets.all(12),
                                ),
                                validator: (value) {
                                  if (value.isEmpty || value == '') {
                                    return 'วันที่ออกบัตรประชาชน';
                                  }
                                  return null;
                                },
                              ),
                            )),
                            IconButton(
                              icon: const Icon(Icons.date_range),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1990),
                                        lastDate: DateTime(2500))
                                    .then((dateValue) => {
                                          thMemberUpdateProfilePage1Request
                                              .cardIssuedDate = dateValue,
                                          cardIssueDateEditor.text = DateHelper
                                              .ConvertDateTimeToDefaultFormatDate(
                                                  dateValue)
                                        });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: defaultPadding * 1.5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: IgnorePointer(
                                    ignoring: true,
                                    child: TextFormField(
                                      controller: cardExpiredDateEditor,
                                      decoration: InputDecoration(
                                        labelText: 'วันที่บัตรหมดอายุ',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(),
                                        ),
                                        isDense: true, // Added this
                                        contentPadding: const EdgeInsets.all(12),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty || value == '') {
                                          return 'วันที่บัตรหมดอายุ';
                                        }
                                        return null;
                                      },
                                    ))),
                            IconButton(
                              icon: const Icon(Icons.date_range),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1990),
                                        lastDate: DateTime(2500))
                                    .then((dateValue) => {
                                          thMemberUpdateProfilePage1Request
                                              .cardExpiredDate = dateValue,
                                          cardExpiredDateEditor.text = DateHelper
                                              .ConvertDateTimeToDefaultFormatDate(
                                                  dateValue)
                                        });
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: defaultPadding * 1.5),
                        child: TextFormField(
                          controller: cardIssuedPlaceTextEditor,
                          decoration: InputDecoration(
                            labelText: 'สถานที่ออกบัตรประจำตัว',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(),
                            ),
                            isDense: true, // Added this
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          onChanged: (value) {
                            setState(() {
                              memberInfo.cardIssuePlace = value;
                              thMemberUpdateProfilePage1Request
                                  .cardIssuedPlace = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: defaultPadding * 1.5),
                        child: TextFormField(
                          controller: phoneNoEditor,
                          decoration: InputDecoration(
                            labelText: 'โทรศัพท์ / โทรศัพท์มือถือ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            isDense: true, // Added this
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          onChanged: (value) {
                            setState(() {
                              memberInfo.mobileNO = value;
                              thMemberUpdateProfilePage1Request.phoneNO = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: defaultPadding * 1.5),
                        child: TextFormField(
                          controller: EmailEditor,
                          decoration: InputDecoration(
                            labelText: 'อีเมล (Email)',
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
                            setState(() {
                              memberInfo.email = value;
                              thMemberUpdateProfilePage1Request.email = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 1.5),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10.0))),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.teal[600]),
                        ),
                        child: const Text(
                          'บันทึก',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              saveMembrProfile();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
