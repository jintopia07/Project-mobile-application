// @dart=2.9
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nat/Config/UI_Config.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MemberProfile/Models/MemberPhoto.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Screens/MemberProfileEng/MemberProfileEngPage1.dart';
import 'package:nat/src/MemberProfile/Services/MemberProfileService.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/utils/memberactivity.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/utils/DateHelper.dart';
import 'package:nat/widgets/customConfirmDialog.dart';

import 'memberprofilethpage1.dart';
import 'memberprofilethpage2.dart';
import 'memberprofilethpage3.dart';
import 'memberprofilethpage4.dart';

class Profile_Memberpages extends StatefulWidget {
  const Profile_Memberpages({Key key}) : super(key: key);

  @override
  _Profile_MemberpagesState createState() => _Profile_MemberpagesState();
}

class _Profile_MemberpagesState extends State<Profile_Memberpages> {
  MemberActivity memberActivity = MemberActivity(WebAPI_Config.mainWebAPIURL);
  DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
  MemberProfileService memberProfileService =
      MemberProfileService(WebAPI_Config.mainWebAPIURL);
  String currentUsername;
  MemberInfo memberInfo;
  MemberPhoto memberPhoto;

  Widget _body = Center(child: const CircularProgressIndicator());
  final Widget _memberPhotoBody = Center(
    child: const CircularProgressIndicator(),
  );

  Widget getPageToGoToProfilePage() {
    if (memberInfo != null) {
      if (memberInfo.isForeigner == true) {
        return MemberProfileEngPage1(memberInfo);
      } else {
        return MemberProfileTHPage1(memberInfo);
      }
    }
    return null;
  }

  @override
  void initState() {
    loadMainMemberProfile();
    super.initState();
  }

  void loadMainMemberProfile() {
    AuthenticationService.getAuthenticatedUser().then((authenticateduser) => {
          memberProfileService
              .getMemberProfile(authenticateduser.username)
              .then((memberProfile) => {
                    memberProfileService
                        .getMemberPhoto(authenticateduser.username)
                        .then((returnedMemberPhoto) => {
                              setState(() => {
                                    memberPhoto = returnedMemberPhoto,
                                    memberInfo = memberProfile,
                                    _body = Scaffold(
                                      appBar: AppBar(
                                        title: const Text('ข้อมูลสมาชิก'),
                                        backgroundColor: Colors.teal[600],
                                      ),
                                      body: SingleChildScrollView(
                                        child: Container(
                                          margin: const EdgeInsets.all(
                                              defaultPadding),
                                          child: Column(
                                            children: <Widget>[
                                              _imageProfile(),
                                              const SizedBox(
                                                height: defaultPadding * 1.5,
                                              ),
                                              _profileheaderSection(),
                                              _profileinfoSection(),
                                              const SizedBox(
                                                height: defaultPadding * 1.5,
                                              ),
                                              _AddressheaderSection(),
                                              _profileAddressSection(),
                                              const SizedBox(
                                                height: defaultPadding * 1.5,
                                              ),
                                              _EducationheaderSection(),
                                              _EducationinfoSection(),
                                              const SizedBox(
                                                height: defaultPadding * 1.5,
                                              ),
                                              _ResearchheaderSection(),
                                              _ResearchinfoSection(),
                                              const SizedBox(
                                                height: defaultPadding * 1.5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  })
                            }),
                  })
        });
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  Widget _imageProfile() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: UI_Config.defaultPadding / 2,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            right: defaultPadding * 6.2, left: defaultPadding * 6.2),
        child: Column(
          children: <Widget>[
            CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60.0,
                child: (memberPhoto != null)
                    ? Image.memory(memberPhoto.bytes)
                    : Image.asset(
                        "assets/images/profile.png",
                        fit: BoxFit.fitHeight,
                      )),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                memberInfo.cardID,
                style: const TextStyle(color: Colors.brown),
              ),
            ),
            const SizedBox(
              height: defaultPadding * 1.5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileheaderSection() => Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     blurRadius: 4,
          //     offset: Offset(4, 8), // Shadow position
          //   ),
          // ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: const Text(
                      "ข้อมูลส่วนตัว",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding * 11,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  getPageToGoToProfilePage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      child: const Text(
                        'แก้ไข',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _profileinfoSection() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        alignment: FractionalOffset.topCenter,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding, top: defaultPadding * 1.5),
                  child: const Text(
                    "ชื่อ - นามสกุล",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 2.8,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 1.5),
                    child: Text((memberInfo.displayName != null)
                        ? memberInfo.displayName
                        : ""),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: const Text(
                    "เพศ",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 5.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: Text((memberInfo.gender != null)
                      ? memberInfo.getGenderName()
                      : ""),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: const Text(
                    "วัน/เดือน/ปีเกิด",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 1.5,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: defaultPadding,
                    ),
                    child: Text((memberInfo.birthDate != null)
                        ? DateHelper.ConvertDateTimeToDefaultFormatDate(
                            memberInfo.birthDate)
                        : ""),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: const Text(
                    "ศาสนา",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 4.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: Text((memberInfo.religion != null)
                      ? memberInfo.religion.religionNameTH
                      : ""),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: const Text(
                    "เชื้อชาติ",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 4.3,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: Text((memberInfo.race != null)
                      ? memberInfo.race.raceNameTH
                      : ""),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: const Text(
                    "สัญชาติ",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 4.2,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: Text((memberInfo.nationality != null)
                      ? memberInfo.nationality.nationalityNameTH
                      : ""),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: const Text(
                    "โทรศัพท์",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 4,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: defaultPadding,
                    ),
                    child: Text((memberInfo.mobileNO != null)
                        ? memberInfo.mobileNO
                        : ""),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: const Text(
                    "E-mail",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 4.3,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: defaultPadding,
                    ),
                    child: Text(
                        (memberInfo.email != null) ? memberInfo.email : ""),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
          ],
        ),
      );

  Widget _AddressheaderSection() => Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     blurRadius: 4,
          //     offset: Offset(4, 8), // Shadow position
          //   ),
          // ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: const Text(
                      "ที่อยู่",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding * 14,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MemberProfileTHPage2(memberInfo)));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      child: const Text(
                        'แก้ไข',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _profileAddressSection() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        alignment: FractionalOffset.topCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: defaultPadding * 1.5, left: defaultPadding),
              child: Text((memberInfo.fullAddress != null)
                  ? memberInfo.fullAddress
                  : ""),
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
          ],
        ),
      );

  Widget _EducationheaderSection() => Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: const Text(
                      "อาชีพและการศึกษา",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding * 8,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MemberProfileTHPage3(memberInfo)));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      child: const Text(
                        'แก้ไข',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _EducationinfoSection() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        alignment: FractionalOffset.topCenter,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding, top: defaultPadding * 1.5),
                  child: const Text(
                    "อาชีพ",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 7,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 1.5),
                    child: Text((memberInfo.career != null)
                        ? memberInfo.career.careerNameTH
                        : ""),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: const Text(
                    "การศึกษาขั้นสูงสุด",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 1.5,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: defaultPadding,
                    ),
                    child: Text((memberInfo.educationLevel != null)
                        ? memberInfo.educationLevel.educationNameTH
                        : ""),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: const Text(
                    "สาขา",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 6.3,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: defaultPadding,
                    ),
                    child: Text((memberInfo.educationField != null)
                        ? memberInfo.educationField.fieldNameTH
                        : ""),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
          ],
        ),
      );

  Widget _ResearchheaderSection() => Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: const Text(
                      "วัตถุประสงค์ในการสืบค้น",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding * 5.5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MemberProfileTHPage4(memberInfo)));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      child: const Text(
                        'แก้ไข',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _ResearchinfoSection() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        alignment: FractionalOffset.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: defaultPadding * 1.5,
              ),
              child: const Text(
                'วัตถุประสงค์ในการนำไปใช้',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: defaultPadding * 0.5,
              ),
              child: Text((memberInfo.researchPurposeOther != null)
                  ? memberInfo.researchPurpose.purposeName
                  : ""),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: defaultPadding * 7, top: defaultPadding * 0.5),
              child: const Text(
                "รายละเอียดเกี่ยวกับเรื่องที่ค้นคว้า",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: defaultPadding * 7, top: defaultPadding * 0.5),
              child: Text((memberInfo.researchingDetail != null)
                  ? memberInfo.researchingDetail
                  : ""),
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
          ],
        ),
      );
}
