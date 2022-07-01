// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/THMemberUpdateProfilePage2Request.dart';
import 'package:nat/src/MemberProfile/Models/infomember.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Services/MemberUpdateProfileService.dart';
import 'package:nat/widgets/customConfirmDialog.dart';

class MemberProfileTHPage2 extends StatefulWidget {
  MemberProfileTHPage2(this.memberInfo);
  MemberInfo memberInfo;

  @override
  _MemberProfileTHPage2State createState() => _MemberProfileTHPage2State();
}

class _MemberProfileTHPage2State extends State<MemberProfileTHPage2> {
  final _formKey = GlobalKey<FormState>();
  DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
  MemberInfo memberInfo;
  THMemberUpdateProfilePage2Request thMemberUpdateProfilePage2Request;

  //List properties
  List<Province> provinces = List<Province>.empty();
  List<District> districts = List<District>.empty();
  List<SubDistrict> subDistricts = List<SubDistrict>.empty();

  //List of dropdown item properties.
  List<DropdownMenuItem> dropdownProvinceItems;
  Province selectedProvince;
  List<DropdownMenuItem> dropdownDistrictItems;
  District selectedDistrict;
  List<DropdownMenuItem> dropdownSubDistrictItems;
  SubDistrict selectedSubDistrict;

  TextEditingController addressNOEditor = TextEditingController();
  TextEditingController villageNameEditor = TextEditingController();
  TextEditingController mooEditor = TextEditingController();
  TextEditingController roadEditor = TextEditingController();
  TextEditingController postCodeEditor = TextEditingController();

  Future<void> loadMasterdata() async {
    //Get Provinces
    await dataProvider.getProvinces().then((p) {
      p.sort((a, b) => a.provinceNameTH.compareTo(b.provinceNameTH));
      provinces = p;
    });

    if (memberInfo.district != null) {
      await loadDistricts(memberInfo.district.provinceCode);
    }

    if (memberInfo.subDistrict != null) {
      await loadSubDistricts(memberInfo.subDistrict.districtCode);
    }
  }

  Future<void> loadDistricts(String provinceCode) async {
    await dataProvider.getDistricts(provinceCode).then((d) => {
          d.sort((a, b) => a.districtNameTH.compareTo(b.districtNameTH)),
          districts = d
        });
  }

  Future<void> setDropdownDistricts() async {
    setState(() {
      selectedDistrict = null;

      dropdownDistrictItems = districts
          .map((d) => DropdownMenuItem(value: d, child: Text(d.districtNameTH)))
          .toList();
    });
  }

  Future<void> loadSubDistricts(String distirctCode) async {
    await dataProvider.getSubDistricts(distirctCode).then((s) => {
          s.sort((a, b) => a.subDistrictNameTH.compareTo(b.subDistrictNameTH)),
          subDistricts = s
        });
  }

  Future<void> setDropdownSubDistricts() async {
    setState(() {
      selectedSubDistrict = null;

      dropdownSubDistrictItems = subDistricts
          .map((e) =>
              DropdownMenuItem(value: e, child: Text(e.subDistrictNameTH)))
          .toList();
    });
  }

  Future<void> setWidgetsProperites() async {
    dropdownProvinceItems = provinces
        .map((p) => DropdownMenuItem(
              value: p,
              child: Text(p.provinceNameTH),
            ))
        .toList();

    dropdownDistrictItems = districts
        .map((d) => DropdownMenuItem(value: d, child: Text(d.districtNameTH)))
        .toList();

    dropdownSubDistrictItems = subDistricts
        .map(
            (e) => DropdownMenuItem(value: e, child: Text(e.subDistrictNameTH)))
        .toList();
  }

  Future<void> initialWidgetValues(MemberInfo memberInfo) async {
    setState(() {
      thMemberUpdateProfilePage2Request =
          THMemberUpdateProfilePage2Request(memberInfo);

      if (memberInfo.province != null) {
        selectedProvince = provinces.firstWhere(
            (p) => p.provinceCode == memberInfo.province.provinceCode);
      }

      if (memberInfo.district != null) {
        selectedDistrict = districts.firstWhere(
            (d) => d.districtCode == memberInfo.subDistrict.districtCode);
      }

      if (memberInfo.subDistrict != null) {
        selectedSubDistrict = subDistricts.firstWhere(
            (s) => s.subDistrictCode == memberInfo.subDistrict.subDistrictCode);
      }
      addressNOEditor.text = memberInfo.addressNO;
      villageNameEditor.text = memberInfo.villageName;
      mooEditor.text = memberInfo.moo;
      roadEditor.text = memberInfo.road;
      postCodeEditor.text = memberInfo.zipCode;
    });
  }

  Future<void> saveMemberProfile() async {
    MemberUpdateProfileService memberUpdateProfileService =
        MemberUpdateProfileService(WebAPI_Config.mainWebAPIURL);

    var response = await memberUpdateProfileService
        .updateTHMemberProfilePage2(thMemberUpdateProfilePage2Request);

    if (response.statusCode == 200) {
      showMessageDialog(context, "NAT Archives", "บันทึกข้อมูลเรียบร้อย").then(
          (result) =>
              {Navigator.of(context).popUntil((route) => route.isFirst)});
    } else {
      String reson = response.reasonPhrase;
      showMessageDialog(context, "", reson);
    }
  }

  InfoMember infoMember;

  @override
  void initState() {
    memberInfo = widget.memberInfo;
    //Wait future method to complte one by one.
    loadMasterdata().whenComplete(() {
      setWidgetsProperites().whenComplete(() {
        initialWidgetValues(memberInfo);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final info = ModalRoute.of(context).settings.arguments as InfoMember;
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
                child: const Text("ที่อยู่เลขที่"),
              ),
              Center(
                child: TextFormField(
                  controller: addressNOEditor,
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
                    setState(() {
                      memberInfo.addressNO = value;
                      thMemberUpdateProfilePage2Request.addressNO = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'ที่อยู่เลขที่';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("หมู่บ้าน"),
              ),
              Center(
                child: TextFormField(
                  controller: villageNameEditor,
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
                    setState(() {
                      memberInfo.villageName = value;
                      thMemberUpdateProfilePage2Request.villageName = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("หมู่ที่"),
              ),
              Center(
                child: TextFormField(
                  controller: mooEditor,
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
                    setState(() {
                      memberInfo.moo = value;
                      thMemberUpdateProfilePage2Request.moo = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("ถนน"),
              ),
              Center(
                child: TextFormField(
                  controller: roadEditor,
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
                    setState(() {
                      memberInfo.road = value;
                      thMemberUpdateProfilePage2Request.road = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("จังหวัด"),
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
                    hint: const Text('จังหวัด'),
                    isExpanded: true,
                    value: selectedProvince,
                    items: dropdownProvinceItems,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          var selectedValue = value as Province;
                          selectedProvince = provinces.firstWhere((p) =>
                              p.provinceCode == selectedValue.provinceCode);
                          thMemberUpdateProfilePage2Request.provinceCode =
                              selectedProvince.provinceCode;

                          loadDistricts(selectedProvince.provinceCode)
                              .then((value) => {setDropdownDistricts()});
                        });
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("อำเภอ"),
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
                    hint: const Text('อำเภอ'),
                    isExpanded: true,
                    value: selectedDistrict,
                    items: dropdownDistrictItems,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          var selectedValue = value as District;
                          selectedDistrict = districts.firstWhere(
                              (District d) =>
                                  d.districtCode == selectedValue.districtCode);
                          thMemberUpdateProfilePage2Request.districtCode =
                              selectedDistrict.districtCode;

                          Future.wait([
                            loadSubDistricts(selectedDistrict.districtCode)
                          ]).then((value) => {
                                Future.wait([setDropdownSubDistricts()])
                              });
                        });
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("ตำบล"),
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
                    hint: const Text('ตำบล'),
                    isExpanded: true,
                    value: selectedSubDistrict,
                    items: dropdownSubDistrictItems,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          var selectedValue = value as SubDistrict;
                          selectedSubDistrict = subDistricts.firstWhere((d) =>
                              d.subDistrictCode ==
                              selectedValue.subDistrictCode);
                          thMemberUpdateProfilePage2Request.subDistrictCode =
                              selectedSubDistrict.subDistrictCode;
                        });
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding, top: defaultPadding),
                child: const Text("รหัสไปรษณีย์"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextField(
                  controller: postCodeEditor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    isDense: true, // Added this
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      memberInfo.zipCode = value;
                      thMemberUpdateProfilePage2Request.postCode = value;
                    });
                  },
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(
              //       bottom: defaultPadding, top: defaultPadding),
              //   child: Text("โทรสาร"),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       border: new OutlineInputBorder(
              //         borderRadius: new BorderRadius.circular(10),
              //         borderSide: new BorderSide(),
              //       ),
              //       isDense: true, // Added this
              //       contentPadding: EdgeInsets.all(12),
              //     ),
              //     onChanged: (value) {
              //       setState(() {
              //         info.fax = value;
              //       });
              //     },
              //   ),
              // ),

              const SizedBox(
                height: defaultPadding * 1.2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
