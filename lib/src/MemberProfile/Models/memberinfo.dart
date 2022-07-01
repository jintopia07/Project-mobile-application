// @dart=2.9

import 'package:nat/src/MasterData/Models/MasterData.dart';

class MemberInfo {
  MemberInfo();

  int id;
  DateTime createdDate;
  String cardID = "";

  int titleNameID = 0;
  TitleName titleName;
  String titleID = "";
  String titleNameTH = "";
  String titleNameOther = "";
  bool isTitleNameOther = false;

  String firstName = "";
  String lastName = "";
  String displayName = "";
  int gender;
  DateTime birthDate;

  int raceID;
  Race race;
  String raceCode = "";
  String raceOther = "";
  bool isRaceOther;

  int nationalityID;
  Nationality nationality;
  String nationalityCode = "";
  String nationalityother = "";
  bool isnationalityOther;

  int religionID;
  Religion religion;
  String religionCode = "";
  String religionOther = "";
  bool isReligionOther;

  bool isForeigner;
  DateTime cardIssueDate;
  DateTime cardExpireDate;
  String cardIssuePlace = "";
  bool isCardLifeTime;

  String addressNO = "";
  String moo = "";
  String road = "";
  String villageName = "";

  int provinceID;
  Province province;
  String provinceCode = "";

  int districtID;
  District district;
  String districtCode = "";

  int subDistrictID;
  SubDistrict subDistrict;
  String subDistrictCode = "";

  String zipCode = "";
  String fullAddress = "";
  String foreignerAddress = "";

  String mobileNO = "";
  String tel = "";
  String fax = "";
  String email = "";

  int careerID;
  Career career;
  String careerCode = "";
  String careerOther = "";
  bool isCareerOther;

  String workOrEducationPlace = "";

  int educationLevelID;
  EducationLevel educationLevel;
  String educationID = "";
  String educationLevelOther = "";
  bool isEducationLevelOther;

  int educationFieldID;
  EducationField educationField;
  String fieldID = "";
  String educationFieldother = "";
  bool isEducationFieldOther;

  int researchPurposeID;
  ResearchPurpose researchPurpose;
  String purposeID = "";
  String researchPurposeOther = "";
  bool isResearchPurposeOther;

  String interestingTopicIDs = "";
  bool isInterestingTopicIDsContainOther;
  String interestingTopicOther = "";
  String researchingDetail = "";
  String username = "";
  String password = "";

  String fullName = "";

  MemberInfo.fromJson(Map<String, dynamic> json) {
    if (json['Career'] != null) {
      career = Career.fromJson(json['Career']);
    }
    if (json['District'] != null) {
      district = District.fromJson(json['District']);
    }
    if (json['EducationField'] != null) {
      educationField = EducationField.fromJson(json['EducationField']);
    }
    if (json['EducationLevel'] != null) {
      educationLevel = EducationLevel.fromJson(json['EducationLevel']);
    }
    if (json['Nationality'] != null) {
      nationality = Nationality.fromJson(json['Nationality']);
    }
    if (json['Province'] != null) {
      province = Province.formJson(json['Province']);
    }
    if (json['Race'] != null) {
      race = Race.fromJson(json['Race']);
    }
    if (json['Religion'] != null) {
      religion = Religion.fromJson(json['Religion']);
    }
    if (json['ResearchPurpose'] != null) {
      researchPurpose = ResearchPurpose.fromJson(json['ResearchPurpose']);
    }
    if (json['SubDistrict'] != null) {
      subDistrict = SubDistrict.fromJson(json['SubDistrict']);
    }
    if (json['TitleName'] != null) {
      titleName = TitleName.fromJson(json['TitleName']);
    }

    id = json['ID'];
    if (json['CreatedDate'] != null) {
      createdDate = DateTime.parse(json['CreatedDate']);
    }
    // createby
    // UpdateDate
    // Updateby
    //Is Deleted
    cardID = json['CardID'];
    titleNameID = json['TitleName_ID'];
    titleID = json['TitleID'];
    titleNameOther = json['TitleNameOther'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    displayName = json['DisplayName'];
    gender = json['Gender'];
    if (json['BirthDate'] != null) {
      birthDate = DateTime.parse(json['BirthDate']);
    }

    raceID = json['Race_ID'];
    raceCode = json['RaceID'];
    raceOther = json['RaceOther'];
    nationalityID = json['Nationality_ID'];
    nationalityCode = json['NationalityID'];
    nationalityother = json['NationalityOther'];
    isForeigner = json['IsForeigner'];
    religionID = json['Religion_ID'];
    religionCode = json['ReligionID'];
    religionOther = json['ReligionOther'];
    if (json['CardIssuedDate'] != null) {
      cardIssueDate = DateTime.parse(json['CardIssuedDate']);
    }
    if (json['CardExpireDate'] != null) {
      cardExpireDate = DateTime.parse(json['CardExpireDate']);
    }

    cardIssuePlace = json['CardIssuePlace'];
    isCardLifeTime = json['IsCardLifeTime'];
    addressNO = json['AddressNO'];
    moo = json['Moo'];
    road = json['Road'];
    villageName = json['VillageName'];
    provinceID = json['Province_ID'];
    provinceCode = json['ProvinceCode'];
    districtID = json['District_ID'];
    districtCode = json['DistrictCode'];
    subDistrictID = json['SubDistrict_ID'];
    subDistrictCode = json['SubDistrictCode'];
    zipCode = json['ZipCode'];
    foreignerAddress = json['ForeignerAddress'];
    mobileNO = json['MobileNO'];
    tel = json['Tel'];
    fax = json['Fax'];
    email = json['Email'];
    careerID = json['Career_ID'];
    careerCode = json['CareerID'];
    careerOther = json['CareerOther'];
    workOrEducationPlace = json['WorkOrEducationPlace'];
    educationLevelID = json['EducationLevel_ID'];
    educationID = json['EducationID'];
    educationLevelOther = json['EducationLevelOther'];
    educationFieldID = json['EducationField_ID'];
    fieldID = json['FieldID'];
    educationFieldother = json['EducationFieldOther'];
    researchPurposeID = json['ResearchPurpose_ID'];
    purposeID = json['PurposeID'];
    researchPurposeOther = json['ResearchPurposeOther'];
    interestingTopicIDs = json['InterestingTopicIDs'];
    interestingTopicOther = json['InterestingTopicOther'];
    researchingDetail = json['ResearchingDetail'];
    username = json['UserName'];
    password = json['Password'];
    fullAddress = json["FullAddress"];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['CardID'] = cardID;
    // json['TitleName_ID']
    if (titleName != null) {
      json['TitleName'] = titleName.createJson();
    }
    json['TitleNameOther'] = titleNameOther;
    json['FirstName'] = firstName;
    json['LastName'] = lastName;
    json['Gender'] = gender;
    json['BirthDate'] = birthDate.toString();
    json['CardIssuedDate'] = cardIssueDate.toString();
    json['CardExpireDate'] = cardExpireDate.toString();
    json['IsCardLifeTime'] = isCardLifeTime;
    json['CardIssuePlace'] = cardIssuePlace;
    // json['Race_ID']
    if (race != null) {
      json['Race'] = race.createJson();
    }
    json['RaceOther'] = raceOther;
    //Nationality_ID
    if (nationality != null) {
      json['Nationality'] = nationality.createJson();
    }
    json['NationalityOther'] = nationalityother;
    //Religion_ID
    if (religion != null) {
      json['Religion'] = religion.createJson();
    }
    json['ReligionOther'] = religionOther;
    json['AddressNO'] = addressNO;
    json['Moo'] = moo;
    json['Road'] = road;
    json['VillageName'] = villageName;
    //ProvinceCode
    if (province != null) {
      json['Province'] = province.createJson();
    }
    //DistrictCode
    if (district != null) {
      json['District'] = district.createJson();
    }
    //SubDistrictCode
    if (subDistrict != null) {
      json['SubDistrict'] = subDistrict.createJson();
    }
    json['ZipCode'] = zipCode;
    json['ForeignerAddress'] = foreignerAddress;
    json['MobileNO'] = mobileNO;
    json['Tel'] = tel;
    json['Fax'] = fax;
    json['Email'] = email;
    //Career_ID
    if (career != null) {
      json['Career'] = career.createJson();
    }
    json['CareerOther'] = careerOther;
    json['WorkOrEducationPlace'] = workOrEducationPlace;
    //EducationLevel_ID
    if (educationLevel != null) {
      json['EducationLevel'] = educationLevel.createJson();
    }
    json['EducationLevelOther'] = educationLevelOther;
    //EducationField_ID
    if (educationField != null) {
      json['EducationField'] = educationField.createJson();
    }
    json['EducationFieldOther'] = educationFieldother;
    //ResearchPurpose_ID
    if (researchPurpose != null) {
      json['ResearchPurpose'] = researchPurpose.createjson();
    }
    json['ResearchPurposeOther'] = researchPurposeOther;
    json['InterestingTopicIDs'] = interestingTopicIDs;
    json['InterestingTopicOther'] = interestingTopicOther;
    json['ResearchingDetail'] = researchingDetail;
    return json;
  }

  String getGenderName() {
    if (gender == 1) {
      return "ชาย";
    } else if (gender == 2) {
      return "หญิง";
    }
    return "";
  }

  String getGenderNameEH() {
    if (gender == 1) {
      return "Men";
    } else if (gender == 2) {
      return "Women";
    }
    return "";
  }
}
