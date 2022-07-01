// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/THMemberUpdateProfilePage4Request.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Services/MemberUpdateProfileService.dart';
import 'package:nat/widgets/customConfirmDialog.dart';

class MemberProfileTHPage4 extends StatefulWidget {
  MemberProfileTHPage4(this.memberInfo);
  MemberInfo memberInfo;

  @override
  _MemberProfileTHPage4State createState() => _MemberProfileTHPage4State();
}

class _MemberProfileTHPage4State extends State<MemberProfileTHPage4> {
  final _formKey = GlobalKey<FormState>();
  DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
  MemberInfo memberInfo;
  THMemberUpdateProfilePage4Request thMemberUpdateProfilePage4Request;

  //master data's properties
  List<ResearchPurpose> researcherPurposes;
  bool researchPurposeOtherVisibility = false;
  ResearchPurpose selectedResearchPurpose;
  List<ResearchTopic> researchTopics;
  bool researchTopicOtherVisibility = false;
  TextEditingController interestingTopicsEditor = TextEditingController();
  TextEditingController researchingDetailEditor = TextEditingController();
  //List of dropdown item properties.
  List<DropdownMenuItem> dropdownResearchPurposeItem;

  Map<String, bool> researchTopicItems = <String, bool>{};
  Map<String, String> researchTopicItemsWithID = <String, String>{};

  var tmpArray = [];
  var tmpSelectedIDs = [];

  getCheckboxItems() {
    researchTopicItems.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      } else {}
    });
    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }

  String getSelectedCheckboxIDs() {
    tmpSelectedIDs.clear();
    researchTopicItems.forEach((key, value) {
      if (value == true) {
        var ent =
            researchTopicItemsWithID.entries.firstWhere((e) => e.value == key);
        if (!tmpSelectedIDs.contains(ent.key)) {
          tmpSelectedIDs.add(ent.key);
        }
      }
    });

    return tmpSelectedIDs.join(",");
  }

  bool isSelectedOtherTopic(List<String> selectedIDs) {
    return (selectedIDs.contains("9999"));
  }

  Future<void> loadMasterData() async {
    await dataProvider.getResearchPurposes().then((r) => {
          setState(() {
            r.sort((a, b) => a.thSorting.compareTo(b.thSorting));
            researcherPurposes = r;
          })
        });

    await dataProvider.getResearchTopic().then((t) => {
          setState(() {
            t.sort((a, b) => a.thSorting.compareTo(b.thSorting));
            researchTopics = t;
          })
        });
  }

  Future<void> setWidgetProperties() async {
    dropdownResearchPurposeItem = researcherPurposes
        .map((rp) => DropdownMenuItem(
              value: rp,
              child: Text(rp.purposeName),
            ))
        .toList();

    for (var e in researchTopics) {
      researchTopicItems[e.topicNameTH] = false;
    }

    for (var e in researchTopics) {
      researchTopicItemsWithID[e.topicID] = e.topicNameTH;
    }
  }

  Future<void> initialWidgetValues(MemberInfo memberInfo) async {
    memberInfo = widget.memberInfo;

    setState(() {
      thMemberUpdateProfilePage4Request =
          THMemberUpdateProfilePage4Request(memberInfo);

      if (memberInfo.researchPurpose != null) {
        selectedResearchPurpose = researcherPurposes.firstWhere(
            (e) => e.purposeID == memberInfo.researchPurpose.purposeID);

        researchPurposeOtherVisibility =
            (memberInfo.researchPurpose.purposeID == "9999");
      }

      //Researching topics
      List<String> interestingTopicIDs =
          memberInfo.interestingTopicIDs.split(",");

      for (var e in interestingTopicIDs) {
        var selectedChoiceNameTH = researchTopicItemsWithID[e];
        researchTopicItems[selectedChoiceNameTH] = true;
      }

      researchTopicOtherVisibility = isSelectedOtherTopic(interestingTopicIDs);

      interestingTopicsEditor.text = memberInfo.interestingTopicOther;
      researchingDetailEditor.text = memberInfo.researchingDetail;
    });
  }

  Future<void> saveMemberProfile() async {
    MemberUpdateProfileService memberUpdateProfileService =
        MemberUpdateProfileService(WebAPI_Config.mainWebAPIURL);

    var response = await memberUpdateProfileService
        .updateTHMemberProfilePage4(thMemberUpdateProfilePage4Request);

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
    Future.wait([loadMasterData()]).whenComplete(() {
      Future.wait([setWidgetProperties()]).whenComplete(() {
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
                child: const Text("วัตถุประสงค์ในการนำไปใช้"),
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
                    hint: const Text('วัตถุประสงค์ในการนำไปใช้'),
                    isExpanded: true,
                    value: selectedResearchPurpose,
                    items: dropdownResearchPurposeItem,
                    onChanged: (value) {
                      setState(() {
                        ResearchPurpose selectedValue =
                            value as ResearchPurpose;
                        thMemberUpdateProfilePage4Request.purposeID =
                            selectedValue.purposeID;

                        selectedResearchPurpose = researcherPurposes.firstWhere(
                            (e) => e.purposeID == selectedValue.purposeID);

                        researchPurposeOtherVisibility =
                            (selectedValue.purposeID == "9999");
                      });
                    },
                  ),
                ),
              ),
              Visibility(
                visible: researchPurposeOtherVisibility,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: defaultPadding, top: defaultPadding),
                      child: const Text("ระบุวัตถุประสงค์ อื่นๆ"),
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
                          thMemberUpdateProfilePage4Request
                              .researchPurposeOther = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("หัวข้อที่เกี่ยวกับเรื่องที่ค้นคว้า"),
              ),
              SizedBox(
                height: 1500.0,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: researchTopicItems.keys.map((String key) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        key,
                        style: const TextStyle(fontSize: 14),
                      ),
                      value: researchTopicItems[key],
                      activeColor: Colors.teal[600],
                      checkColor: Colors.white,
                      onChanged: (bool value) {
                        setState(() {
                          researchTopicItems[key] = value;
                          var selectedIDs = getSelectedCheckboxIDs();
                          thMemberUpdateProfilePage4Request
                              .selectedInterestingTopics_ID = selectedIDs;

                          researchTopicOtherVisibility =
                              isSelectedOtherTopic(selectedIDs.split(","));
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                visible: researchTopicOtherVisibility,
                child: Padding(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  child: TextFormField(
                    controller: interestingTopicsEditor,
                    decoration: InputDecoration(
                      labelText: 'อื่นๆ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      isDense: true, // Added this
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    onChanged: (value) {
                      thMemberUpdateProfilePage4Request.interestingTopicOther =
                          value;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("รายละเอียดเกี่ยวกับเรื่องที่ค้นคว้า *"),
              ),
              Center(
                child: TextFormField(
                  controller: researchingDetailEditor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    isDense: true, // Added this
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      memberInfo.researchingDetail = value;
                      thMemberUpdateProfilePage4Request.researchDetail = value;
                    });
                  },
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
                      saveMemberProfile();
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
