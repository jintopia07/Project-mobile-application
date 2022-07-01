// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/ForeignMemberUpdateProfilePage3Request.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Services/MemberUpdateProfileService.dart';
import 'package:nat/widgets/customConfirmDialog.dart';
import 'memberprofileengpage4.dart';

class MemberProfileEngPage3 extends StatefulWidget {
  MemberProfileEngPage3(this.memberInfo);
  MemberInfo memberInfo;

  @override
  _MemberProfileEngPage3State createState() => _MemberProfileEngPage3State();
}

class _MemberProfileEngPage3State extends State<MemberProfileEngPage3> {
  MemberInfo memberInfo;
  DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
  ForeignMemberUpdateProfilePage3Request foreignMemberUpdateProfilePage3Request;

  //List properites.
  List<Career> careers = <Career>[];
  Career selectedCareer;
  List<EducationLevel> educationLevels = <EducationLevel>[];
  EducationLevel selectedEducationLevel;
  List<EducationField> educationFields = <EducationField>[];
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
            c.sort((a, b) => a.engSorting.compareTo(b.engSorting));
            careers = c;
          }),
        });

    await dataProvider.getEducationFields().then((edf) => {
          setState(() {
            edf.sort((a, b) => a.enSorting.compareTo(b.enSorting));
            educationFields = edf;
          }),
        });

    await dataProvider.getEducationLevels().then((edl) => {
          setState(() {
            edl.sort((a, b) => a.engSorting.compareTo(b.engSorting));
            educationLevels = edl;
          }),
        });
  }

  Future<void> setWidgetsProperites() async {
    dropdownCareers = careers
        .map((c) => DropdownMenuItem(
              value: c,
              child: Text(c.careerNameENG),
            ))
        .toList();

    dropdownEducationLevelItems = educationLevels
        .map((edl) =>
            DropdownMenuItem(value: edl, child: Text(edl.educationNameENG)))
        .toList();

    dropdownEducationFields = educationFields
        .map((edf) => DropdownMenuItem(
              value: edf,
              child: Text(edf.fieldNameENG),
            ))
        .toList();
  }

  Future<void> initialWidgetValues(MemberInfo memberInfo) async {
    setState(() {
      foreignMemberUpdateProfilePage3Request =
          ForeignMemberUpdateProfilePage3Request(memberInfo);

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
    var response =
        await memberUpdateProfileService.updateForeignMemberProfilePage3(
            foreignMemberUpdateProfilePage3Request);
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
        title: const Text('Career / Educational data'),
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
                child: const Text("Career"),
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
                    hint: const Text('Career'),
                    isExpanded: true,
                    value: selectedCareer,
                    items: dropdownCareers,
                    onChanged: (value) {
                      selectedCareer = value;
                      memberInfo.career = value;
                      foreignMemberUpdateProfilePage3Request.careerID =
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
                      child: const Text("Other"),
                    ),
                    Container(
                      child: TextFormField(
                        controller: careerOtherEditor,
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
                          memberInfo.careerOther = value;
                          foreignMemberUpdateProfilePage3Request.careerOther =
                              value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("Work or education place"),
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
                    foreignMemberUpdateProfilePage3Request
                        .workOrEducationPlace = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("Highest education level"),
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
                      hint: const Text('education level'),
                      isExpanded: true,
                      items: dropdownEducationLevelItems,
                      value: selectedEducationLevel,
                      onChanged: (value) {
                        selectedEducationLevel = value;
                        memberInfo.educationLevel = value;
                        foreignMemberUpdateProfilePage3Request.educationID =
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
                      child: const Text("Other"),
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
                          foreignMemberUpdateProfilePage3Request
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
                child: const Text("Educaion field"),
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
                      hint: const Text('Educaion field'),
                      isExpanded: true,
                      items: dropdownEducationFields,
                      value: selectedEducationField,
                      onChanged: (value) {
                        selectedEducationField = value;
                        memberInfo.educationField = value;
                        foreignMemberUpdateProfilePage3Request.fieldID =
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
                      child: const Text("Other"),
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
                          foreignMemberUpdateProfilePage3Request
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
                      'Save',
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
