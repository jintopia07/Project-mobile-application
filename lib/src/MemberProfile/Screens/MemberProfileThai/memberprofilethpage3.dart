// @dart=2.9
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/THMemberUpdateProfilePage3Request.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Services/MemberUpdateProfileService.dart';
import 'package:nat/widgets/customConfirmDialog.dart';

class MemberProfileTHPage3 extends StatefulWidget {
  MemberProfileTHPage3(this.memberInfo);
  MemberInfo memberInfo;

  @override
  _MemberProfileTHPage3State createState() => _MemberProfileTHPage3State();
}

class _MemberProfileTHPage3State extends State<MemberProfileTHPage3> {
  MemberInfo memberInfo;
  DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
  THMemberUpdateProfilePage3Request thMemberUpdateProfilePage3Request;
  //List properites.
  List<Career> careers;
  Career selectedCareer;
  List<EducationLevel> educationLevels;
  EducationLevel selectedEducationLevel;
  List<EducationField> educationFields;
  EducationField selectedEducationField;
  //List of dropdown item properties.
  List<DropdownMenuItem> dropdownCareers;
  List<DropdownMenuItem> dropdownEducationLevelItems;
  List<DropdownMenuItem> dropdownEducationFields;

  TextEditingController careerOtherEditor = TextEditingController();
  TextEditingController workOrEducationPlaceEditor = TextEditingController();
  TextEditingController educationFieldotherEditor = TextEditingController();
  TextEditingController educationLevelOtherEditor = TextEditingController();

  bool visibilitycareerOther = false;
  bool visibilityeducationFieldother = false;
  bool visibilityeducationLevelOther = false;

  Future<void> loadMasterdata() async {
    await dataProvider.getCareers().then((c) => {
          setState(() {
            c.sort((a, b) => a.thSorting.compareTo(b.thSorting));
            careers = c;
          }),
        });

    await dataProvider.getEducationFields().then((edf) => {
          setState(() {
            edf.sort((a, b) => a.thSorting.compareTo(b.thSorting));
            educationFields = edf;
          }),
        });

    await dataProvider.getEducationLevels().then((edl) => {
          setState(() {
            edl.sort((a, b) => a.thSorting.compareTo(b.thSorting));
            educationLevels = edl;
          }),
        });
  }

  Future<void> setWidgetsProperites() async {
    setState(() {
      dropdownCareers = careers
          .map((c) => DropdownMenuItem(
                value: c,
                child: Text(c.careerNameTH),
              ))
          .toList();

      dropdownEducationLevelItems = educationLevels
          .map((edl) =>
              DropdownMenuItem(value: edl, child: Text(edl.educationNameTH)))
          .toList();

      dropdownEducationFields = educationFields
          .map((edf) => DropdownMenuItem(
                value: edf,
                child: Text(edf.fieldNameTH),
              ))
          .toList();
    });
  }

  Future<void> initialWidgetValues(MemberInfo memberInfo) async {
    setState(() {
      thMemberUpdateProfilePage3Request =
          THMemberUpdateProfilePage3Request(memberInfo);

      if (memberInfo.career != null) {
        selectedCareer =
            careers.firstWhere((c) => c.careerID == memberInfo.career.careerID);
        visibilitycareerOther = (memberInfo.career.careerID == '9999');
      }

      if (memberInfo.educationField != null) {
        selectedEducationField = educationFields.firstWhere(
            (edf) => edf.fieldID == memberInfo.educationField.fieldID);
        visibilityeducationFieldother =
            (memberInfo.educationField.fieldID == '9999');
      }

      if (memberInfo.educationLevel != null) {
        selectedEducationLevel = educationLevels.firstWhere(
            (edl) => edl.educationID == memberInfo.educationLevel.educationID);
        visibilityeducationLevelOther =
            (memberInfo.educationLevel.educationID == '9999');
      }

      educationFieldotherEditor.text = memberInfo.educationFieldother;
      careerOtherEditor.text = memberInfo.careerOther;
      workOrEducationPlaceEditor.text = memberInfo.workOrEducationPlace;
      educationLevelOtherEditor.text = memberInfo.educationLevelOther;
    });
  }

  Future<void> saveMemberProfile() async {
    MemberUpdateProfileService memberUpdateProfileService =
        MemberUpdateProfileService(WebAPI_Config.mainWebAPIURL);

    var response = await memberUpdateProfileService
        .updateTHMemberProfilePage3(thMemberUpdateProfilePage3Request);

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
          margin: const EdgeInsets.only(
              top: defaultPadding * 1.5,
              right: defaultPadding * 1.5,
              left: defaultPadding * 1.5,
              bottom: defaultPadding * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("อาชีพ"),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(
                    left: defaultPadding, right: defaultPadding),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    hint: const Text('อาชีพ'),
                    isExpanded: true,
                    items: dropdownCareers,
                    value: selectedCareer,
                    onChanged: (value) {
                      selectedCareer = value;
                      memberInfo.career = value;
                      thMemberUpdateProfilePage3Request.careerID =
                          selectedCareer.careerID;

                      setState(() {
                        visibilitycareerOther =
                            (memberInfo.career.careerID == '9999');
                      });
                    },
                  ),
                ),
              ),
              Visibility(
                visible: visibilitycareerOther,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: defaultPadding, top: defaultPadding),
                      child: const Text("ระบุอาชีพอื่นๆ"),
                    ),
                    Container(
                      child: TextFormField(
                        controller: careerOtherEditor,
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
                          memberInfo.careerOther = value;
                          thMemberUpdateProfilePage3Request.careerOther = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("สถานที่ทำงาน/สถานศึกษา"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextField(
                  controller: workOrEducationPlaceEditor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    isDense: true, // Added this
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  onChanged: (value) {
                    memberInfo.workOrEducationPlace = value;
                    thMemberUpdateProfilePage3Request.workOrEducationPlace =
                        value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("ระดับการศึกษา"),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(
                    left: defaultPadding, right: defaultPadding),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      hint: const Text('ระดับการศึกษา'),
                      isExpanded: true,
                      items: dropdownEducationLevelItems,
                      value: selectedEducationLevel,
                      onChanged: (value) {
                        selectedEducationLevel = value;
                        memberInfo.educationLevel = value;
                        thMemberUpdateProfilePage3Request.educationID =
                            selectedEducationLevel.educationID;

                        setState(() {
                          visibilityeducationLevelOther =
                              (memberInfo.educationLevel.educationID == '9999');
                        });
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: visibilityeducationLevelOther,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: defaultPadding, top: defaultPadding),
                      child: const Text("ระบุระดับการศึกษา อื่นๆ"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: TextField(
                        controller: educationLevelOtherEditor,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(),
                          ),
                          isDense: true, // Added this
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        onChanged: (value) {
                          memberInfo.educationLevelOther = value;
                          thMemberUpdateProfilePage3Request
                              .educationLevelOther = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("สาขา"),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(
                    left: defaultPadding, right: defaultPadding),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      hint: const Text('ระบุสาขา'),
                      isExpanded: true,
                      items: dropdownEducationFields,
                      value: selectedEducationField,
                      onChanged: (value) {
                        selectedEducationField = value;
                        memberInfo.educationField = value;
                        thMemberUpdateProfilePage3Request.fieldID =
                            selectedEducationField.fieldID;

                        setState(() {
                          visibilityeducationFieldother =
                              (memberInfo.educationField.fieldID == '9999');
                        });
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: visibilityeducationFieldother,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: defaultPadding, top: defaultPadding),
                      child: const Text("ระบุ สาขาอื่นๆ"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: TextField(
                        controller: educationFieldotherEditor,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(),
                          ),
                          isDense: true, // Added this
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        onChanged: (value) {
                          memberInfo.educationFieldother = value;
                          thMemberUpdateProfilePage3Request
                              .educationFieldOther = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: defaultPadding * 1.2,
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
                      'บันทึก',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        saveMemberProfile();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
