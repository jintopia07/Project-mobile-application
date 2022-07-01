// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/UI_Config.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MemberProfile/Models/MemberPhoto.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Services/MemberProfileService.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/utils/memberactivity.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/src/MemberProfile/Screens/MemberProfileThai/memberprofilethpage1.dart';
import 'package:nat/utils/DateHelper.dart';

import 'memberprofileengpage1.dart';
import 'memberprofileengpage2.dart';
import 'memberprofileengpage3.dart';
import 'memberprofileengpage4.dart';

class Profile_Member_Engpages extends StatefulWidget {
  const Profile_Member_Engpages({Key key}) : super(key: key);

  @override
  _Profile_Member_EngpagesState createState() =>
      _Profile_Member_EngpagesState();
}

class _Profile_Member_EngpagesState extends State<Profile_Member_Engpages> {
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
                                    memberInfo = memberProfile,
                                    memberPhoto = returnedMemberPhoto,
                                    _body = Scaffold(
                                      appBar: AppBar(
                                        title: const Text('Personal data'),
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
                                  }),
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
                      "Personal data",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding * 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MemberProfileEngPage1(memberInfo)));
                    },
                    child: Container(
                   padding: const EdgeInsets.only(
                         right: defaultPadding * 1.5),
                      child: const Text(
                        'Edit',
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
                    "First - Last name",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 1,
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
                    "Sex",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 5.6,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: Text((memberInfo.gender != null)
                      ? memberInfo.getGenderNameEH()
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
                    "Birth date",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 3,
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
                    "Religion",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 3.9,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: Text((memberInfo.religion != null)
                      ? memberInfo.religion.religionNameENG
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
                    "Nationality",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 2.6,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: Text((memberInfo.race != null)
                      ? memberInfo.race.raceNameENG
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
                    "Race",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 5.2,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                  ),
                  child: Text((memberInfo.nationality != null)
                      ? memberInfo.nationality.nationalityNameENG
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
                    "Mobile No.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 2.9,
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
                  width: defaultPadding * 4.5,
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
                      "Address",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding * 12,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MemberProfileEngPage2(memberInfo)));
                    },
                    child: Container(
                    padding: const EdgeInsets.only(
                         right: defaultPadding * 1.5),
                      child: const Text(
                        'Edit',
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
              child: Text((memberInfo.foreignerAddress != null)
                  ? memberInfo.foreignerAddress
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
                      "Career / Educational data",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding * 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MemberProfileEngPage3(memberInfo)));
                    },
                    child: Container(
                    padding: const EdgeInsets.only(
                         right: defaultPadding * 1.5),
                      child: const Text(
                        'Edit',
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
                    "Career",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 6.6,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding * 1.5, right: defaultPadding),
                    child: Text(
                      (memberInfo.career != null)
                          ? memberInfo.career.careerNameENG
                          : "",
                      textAlign: TextAlign.end,
                    ),
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
                    "Highest education level",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 1.5,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: defaultPadding, right: defaultPadding),
                    child: Text(
                      (memberInfo.educationLevel != null)
                          ? memberInfo.educationLevel.educationNameENG
                          : "",
                      textAlign: TextAlign.end,
                    ),
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
                    "Educaion field",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding * 5.1,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: defaultPadding, right: defaultPadding),
                    child: Text(
                      (memberInfo.educationField != null)
                          ? memberInfo.educationField.fieldNameENG
                          : "",
                      textAlign: TextAlign.end,
                    ),
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
                      "Researching objective",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding * 6,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MemberProfileEngPage4(memberInfo)));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                         right: defaultPadding * 1.5),
                      child: const Text(
                        'Edit',
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
                'Researching objective',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: defaultPadding * 0.5,
              ),
              child: Text((memberInfo.researchPurpose != null)
                  ? memberInfo.researchPurpose.purposeNameENG
                  : ""),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: defaultPadding * 7, top: defaultPadding * 0.5),
              child: const Text(
                "Research detail",
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
