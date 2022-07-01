// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/MemberProfile/Models/UpdateProfile/ForeignMemberUpdateProfilePage1Request.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Services/MemberUpdateProfileService.dart';
import 'package:nat/utils/DateHelper.dart';
import 'package:nat/widgets/customConfirmDialog.dart';

class MemberProfileEngPage1 extends StatefulWidget {
  MemberInfo memberInfo;
  MemberProfileEngPage1(this.memberInfo);

  @override
  _MemberProfileEngPage1State createState() => _MemberProfileEngPage1State();
}

class _MemberProfileEngPage1State extends State<MemberProfileEngPage1> {
  final _formKey = GlobalKey<FormState>();
  MemberInfo memberInfo;
  DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);

  ForeignMemberUpdateProfilePage1Request foreignMemberUpdateProfilePage1Request;

  //masterdata list properties.
  List<TitleName> titleNames = <TitleName>[];
  List<Religion> religions = <Religion>[];
  List<Nationality> nationalities = <Nationality>[];
  List<Race> races = <Race>[];
  int _selectedGenderValue = -1;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _selectedGenderValue = value;
    });
  }

  //Drop down button items.
  List<DropdownMenuItem> dropdownTitleNameItems;
  TitleName selectedTitleName;
  bool isTitleNameOtherSelected = false;
  TextEditingController titleNameOtherTextEditor = TextEditingController();

  List<DropdownMenuItem> dropdownReligionItems;
  Religion selectedReligion;
  bool isReligionOtherSelected = false;
  TextEditingController otherReligionEditor = TextEditingController();

  List<DropdownMenuItem> dropdownNationalityItems;
  Nationality selectedNationlity;
  bool isNationlityOtherSelected = false;
  TextEditingController nationlityOtherEditor = TextEditingController();

  List<DropdownMenuItem> dropdownRaceItems;
  Race selectedRace;
  bool isRaceOtherSelected = false;
  TextEditingController raceOtherEditor = TextEditingController();

  TextEditingController nameTextEditor = TextEditingController();
  TextEditingController lastNameTextEditor = TextEditingController();
  DateTime _selectedBirthDate;
  TextEditingController birthDateEditor = TextEditingController();
  TextEditingController cardIDTextEditor = TextEditingController();
  DateTime _selectedCardIssueDate;
  TextEditingController cardIssueDateEditor = TextEditingController();
  TextEditingController phoneNoEditor = TextEditingController();
  TextEditingController EmailEditor = TextEditingController();

  Future<void> loadMasterdata() async {
    //Get title name.
    await dataProvider.getTitleNames().then((t) {
      setState(() {
        t.sort((a, b) => a.engSorting.compareTo(b.engSorting));
        titleNames = t;
      });
    });

    //Get religion name.
    await dataProvider.getReligions().then((r) {
      setState(() {
        r.sort((a, b) => a.engSorting.compareTo(b.engSorting));
        religions = r;
      });
    });
    //Get nationality.
    await dataProvider.getNationalities().then((n) {
      setState(() {
        n.sort((a, b) => a.engSorting.compareTo(b.engSorting));
        nationalities = n;
      });
    });

    //Get Races
    await dataProvider.getRaces().then((r) => {
          setState(() {
            r.sort((a, b) => a.engSorting.compareTo(b.engSorting));
            races = r;
          })
        });
  }

  Future<void> setWidgetsProperites() async {
    setState(() {
      dropdownTitleNameItems = titleNames
          .map((t) => DropdownMenuItem(
                value: t,
                child: Text(t.titleNameENG),
              ))
          .toList();
      dropdownReligionItems = religions
          .map((r) => DropdownMenuItem(
                value: r,
                child: Text(r.religionNameENG),
              ))
          .toList();
      dropdownNationalityItems = nationalities
          .map((n) => DropdownMenuItem(
                value: n,
                child: Text(n.nationalityNameENG),
              ))
          .toList();
      dropdownRaceItems = races
          .map((r) => DropdownMenuItem(
                value: r,
                child: Text(r.raceNameENG),
              ))
          .toList();
    });
  }

  convertDatetoSpecificFormatString(DateTime dateTime) {
    if (dateTime != null) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  Future<void> initialWidgetValues(MemberInfo memberInfo) async {
    setState(() {
      foreignMemberUpdateProfilePage1Request =
          ForeignMemberUpdateProfilePage1Request(memberInfo);

      if (memberInfo.titleName != null) {
        TitleName getTitleName = titleNames
            .firstWhere((t) => t.titleID == memberInfo.titleName.titleID);

        if (getTitleName != null) {
          selectedTitleName = getTitleName;
          isTitleNameOtherSelected = (getTitleName.titleID == '9999');
        }
      }

      titleNameOtherTextEditor.text = memberInfo.titleNameOther;
      nameTextEditor.text = memberInfo.firstName;
      lastNameTextEditor.text = memberInfo.lastName;
      _selectedGenderValue = memberInfo.gender;
      phoneNoEditor.text = memberInfo.mobileNO;
      EmailEditor.text = memberInfo.email;

      if (memberInfo.birthDate != null) {
        _selectedBirthDate = memberInfo.birthDate;
        birthDateEditor.text =
            DateHelper.ConvertDateTimeToDefaultFormatDate(memberInfo.birthDate);
      }
      if (memberInfo.religion != null) {
        Religion getReligion = religions
            .firstWhere((r) => r.religionID == memberInfo.religion.religionID);
        if (getReligion != null) {
          selectedReligion = getReligion;
          isReligionOtherSelected = (getReligion.religionID == '9999');
        }
      }
      if (memberInfo.nationality != null) {
        Nationality getNationality = nationalities.firstWhere(
            (n) => n.natinalityID == memberInfo.nationality.natinalityID);
        if (getNationality != null) {
          selectedNationlity = getNationality;
          isNationlityOtherSelected = (getNationality.natinalityID == '9999');
        }
      }
      if (memberInfo.race != null) {
        Race getRace =
            races.firstWhere((r) => r.raceID == memberInfo.race.raceID);
        if (getRace != null) {
          selectedRace = getRace;
          isRaceOtherSelected = (getRace.raceID == '9999');
        }
      }

      cardIDTextEditor.text = memberInfo.cardID;
      if (memberInfo.cardIssueDate != null) {
        _selectedCardIssueDate = memberInfo.cardIssueDate;
        cardIssueDateEditor.text =
            DateHelper.ConvertDateTimeToDefaultFormatDate(
                memberInfo.cardIssueDate);
      }
    });
  }

  Future<void> saveMemberProfile() async {
    MemberUpdateProfileService memberUpdateProfileService =
        MemberUpdateProfileService(WebAPI_Config.mainWebAPIURL);
    var response =
        await memberUpdateProfileService.updateForeignMemberProfilePage1(
            foreignMemberUpdateProfilePage1Request);
    if (response.statusCode == 200) {
      showMessageENDialog(context, "NAT Archives", "Complete")
          .then((result) => {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const Profile_Member_Engpages()),
                //    )
                Navigator.of(context).popUntil((route) => route.isFirst)
              });
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
        title: const Text('Personal data'),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
                        hint: const Text('Title name'),
                        isExpanded: true,
                        value: selectedTitleName,
                        items: dropdownTitleNameItems,
                        onChanged: (value) {
                          setState(() {
                            selectedTitleName = value;
                            memberInfo.titleName = selectedTitleName;
                            foreignMemberUpdateProfilePage1Request.titleID =
                                selectedTitleName.titleID;
                            isTitleNameOtherSelected =
                                (selectedTitleName.titleID == '9999');
                          });
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isTitleNameOtherSelected,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: defaultPadding * 1.5),
                          child: TextFormField(
                            controller: titleNameOtherTextEditor,
                            decoration: InputDecoration(
                              labelText: 'In case select other title name.',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                memberInfo.titleNameOther = value;
                                foreignMemberUpdateProfilePage1Request
                                    .titleNameOther = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty && isTitleNameOtherSelected) {
                                return 'other title name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 1.5),
                    child: TextFormField(
                      controller: nameTextEditor,
                      decoration: InputDecoration(
                        labelText: 'First name',
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
                          foreignMemberUpdateProfilePage1Request.firstName =
                              value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'First name';
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
                        labelText: 'Last name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(),
                        ),
                        isDense: true, // Added this
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      onChanged: (value) {
                        setState(() {
                          memberInfo.lastName = value;
                          foreignMemberUpdateProfilePage1Request.lastName =
                              value;
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
                  Container(
                    padding: const EdgeInsets.only(top: defaultPadding * 1.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                            value: 1,
                            groupValue: _selectedGenderValue,
                            onChanged: _handleRadioValueChange1),
                        Text(
                          'Men',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          width: defaultPadding * 1.5,
                        ),
                        Radio(
                            value: 2,
                            groupValue: _selectedGenderValue,
                            onChanged: _handleRadioValueChange1),
                        Text(
                          'Women',
                          style: TextStyle(fontSize: 14),
                        ),
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
                                labelText: 'Birth date',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(),
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
                                      foreignMemberUpdateProfilePage1Request
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
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: DropdownButtonFormField(
                        hint: const Text('Religion'),
                        isExpanded: true,
                        items: dropdownReligionItems,
                        value: selectedReligion,
                        onChanged: (value) {
                          setState(() {
                            selectedReligion = value;
                            memberInfo.religion = value;
                            foreignMemberUpdateProfilePage1Request.religionID =
                                selectedReligion.religionID;
                            isReligionOtherSelected =
                                (selectedReligion.religionID == '9999');
                          });
                        },
                        validator: (value) {
                          if (value == null && selectedReligion == null) {
                            return 'Religion';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isReligionOtherSelected,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: defaultPadding * 1.5),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'In case select other religion.',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                memberInfo.religionOther = value;
                                foreignMemberUpdateProfilePage1Request
                                    .religionOther = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty && isReligionOtherSelected) {
                                return 'other religion';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding * 1.5),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.only(
                        left: defaultPadding, right: defaultPadding),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: DropdownButtonFormField(
                        hint: const Text('Nationality'),
                        isExpanded: true,
                        items: dropdownNationalityItems,
                        value: selectedNationlity,
                        onChanged: (value) {
                          setState(() {
                            selectedNationlity = value;
                            memberInfo.nationality = value;
                            foreignMemberUpdateProfilePage1Request
                                    .nationalityID =
                                selectedNationlity.natinalityID;
                            isNationlityOtherSelected =
                                (selectedNationlity.natinalityID == '9999');
                          });
                        },
                        validator: (value) {
                          if (value == null && selectedNationlity == null) {
                            return 'nationality';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isNationlityOtherSelected,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: defaultPadding * 1.5),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'In case select other nationality.',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                memberInfo.nationalityother = value;
                                foreignMemberUpdateProfilePage1Request
                                    .nationalityOther = value;
                              });
                            },
                            validator: (value) {
                              if (value == null && selectedNationlity == null) {
                                return 'Other nationality';
                              }
                              return null;
                            },
                          ),
                        ),
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
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        hint: const Text('Race'),
                        isExpanded: true,
                        items: dropdownRaceItems,
                        value: selectedRace,
                        onChanged: (value) {
                          setState(() {
                            selectedRace = value;
                            memberInfo.race = value;
                            foreignMemberUpdateProfilePage1Request.raceID =
                                selectedRace.raceID;
                            isRaceOtherSelected =
                                (selectedRace.raceID == '9999');
                          });
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isRaceOtherSelected,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: defaultPadding * 1.5),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'In case select other race.',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                memberInfo.raceOther = value;
                                foreignMemberUpdateProfilePage1Request
                                    .raceOther = value;
                              });
                            },
                            validator: (value) {
                              if (value == null && selectedRace == null) {
                                return 'select other race';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 1.5),
                    child: TextFormField(
                      controller: cardIDTextEditor,
                      decoration: InputDecoration(
                        labelText: 'Passport card ID.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(),
                        ),
                        isDense: true, // Added this
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      onChanged: (value) {
                        memberInfo.cardID = value;
                        foreignMemberUpdateProfilePage1Request.cardID = value;
                      },
                      validator: (value) {
                        if (value == null && selectedRace == null) {
                          return 'Passport card ID';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 1.5),
                    child: TextFormField(
                      controller: phoneNoEditor,
                      decoration: InputDecoration(
                        labelText: 'Mobile No.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(),
                        ),
                        isDense: true, // Added this
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      onChanged: (value) {
                        setState(() {
                          memberInfo.mobileNO = value;
                          foreignMemberUpdateProfilePage1Request.phoneNO =
                              value;
                        });
                      },
                      validator: (value) {
                        if (value == null && selectedRace == null) {
                          return 'Mobile No';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding * 1.5),
                    child: TextFormField(
                      controller: EmailEditor,
                      decoration: InputDecoration(
                        labelText: 'Email',
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
                          return 'Email';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          memberInfo.email = value;
                          foreignMemberUpdateProfilePage1Request.email = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              saveMemberProfile();
                            }
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
