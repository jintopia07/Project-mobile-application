// @dart=2.9
class BankInfo {
  int id;
  String nameTH;
  String nameENG;
  String shortNameTH;
  String shortNameENG;

  BankInfo(
      {this.id,
      this.nameTH,
      this.nameENG,
      this.shortNameTH,
      this.shortNameENG});

  BankInfo.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      id = json['ID'];
      nameTH = json['Name_TH'];
      nameENG = json['Name_ENG'];
      shortNameTH = json['ShortName_TH'];
      shortNameENG = json['ShortName_ENG'];
    }
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['ID'] = id;
    json['Name_TH'] = nameTH;
    json['Name_ENG'] = nameENG;
    json['ShortName_TH'] = shortNameTH;
    json['ShortName_ENG'] = shortNameENG;
    return json;
  }
}

class PaymentSolution {
  int id;
  String solutionName;

  PaymentSolution({this.id, this.solutionName});

  PaymentSolution.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      id = json['ID'];
      solutionName = json['SolutionName'];
    }
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['ID'] = id;
    json['SolutionName'] = solutionName;
    return json;
  }
}

class TitleName {
  String titleID;
  String titleNameTH;
  String titleNameENG;
  int thSorting;
  int engSorting;
  TitleName(
      {this.titleID,
      this.titleNameTH,
      this.titleNameENG,
      this.thSorting,
      this.engSorting});

  TitleName.fromJson(Map<String, dynamic> json) {
    titleID = json['TitleID'];
    titleNameTH = json['TitleNameTH'];
    titleNameENG = json['TitleNameENG'];
    thSorting = json['TH_Sorting'];
    engSorting = json['ENG_Sorting'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['TitleID'] = titleID;
    json['TitleNameTH'] = titleNameTH;
    json['TitleNameENG'] = titleNameENG;
    json['TH_Sorting'] = thSorting;
    json['ENG_Sorting'] = engSorting;
    return json;
  }
}

class Career {
  String careerID;
  String careerNameTH;
  String careerNameENG;
  int thSorting;
  int engSorting;
  Career(
      {this.careerID,
      this.careerNameTH,
      this.careerNameENG,
      this.thSorting,
      this.engSorting});

  Career.fromJson(Map<String, dynamic> json) {
    careerID = json['CareerID'];
    careerNameTH = json['CareerNameTH'];
    careerNameENG = json['CareerNameENG'];
    thSorting = json['TH_Sorting'];
    engSorting = json['ENG_Sorting'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['CareerID'] = careerID;
    json['CareerNameTH'] = careerNameTH;
    json['CareerNameENG'] = careerNameENG;
    json['TH_Sorting'] = thSorting;
    json['ENG_Sorting'] = engSorting;
    return json;
  }
}

class EducationField {
  String fieldID;
  String fieldNameTH;
  String fieldNameENG;
  int thSorting;
  int enSorting;

  EducationField.fromJson(Map<String, dynamic> json) {
    fieldID = json['FieldID'];
    fieldNameTH = json['FieldNameTH'];
    fieldNameENG = json['FieldNameENG'];
    thSorting = json['TH_Sorting'];
    enSorting = json['ENG_Sorting'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['FieldID'] = fieldID;
    json['FieldNameTH'] = fieldNameTH;
    json['FieldNameENG'] = fieldNameENG;
    json['TH_Sorting'] = thSorting;
    json['ENG_Sorting'] = enSorting;
    return json;
  }
}

class EducationLevel {
  String educationID;
  String educationNameTH;
  String educationNameENG;
  int thSorting;
  int engSorting;

  EducationLevel.fromJson(Map<String, dynamic> json) {
    educationID = json['EducationID'];
    educationNameTH = json['EducationNameTH'];
    educationNameENG = json['EducationNameENG'];
    thSorting = json['TH_Sorting'];
    engSorting = json['ENG_Sorting'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['EducationID'] = educationID;
    json['EducationNameTH'] = educationNameTH;
    json['EducationNameENG'] = educationNameENG;
    json['TH_Sorting'] = thSorting;
    json['ENG_Sorting'] = engSorting;
    return json;
  }
}

class NATBranch {
  int id;
  String branchID;
  String branchNameTH;
  String branchNameENG;

  NATBranch.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    branchID = json['Branch_ID'];
    branchNameTH = json['BranchName_TH'];
    branchNameENG = json['BranchName_ENG'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['ID'] = id;
    json['Branch_ID'] = branchID;
    json['BranchName_TH'] = branchNameTH;
    json['BranchName_ENG'] = branchNameENG;
    return json;
  }
}

class Nationality {
  Nationality();
  String natinalityID;
  String nationalityNameTH;
  String nationalityNameENG;
  int thSorting;
  int engSorting;

  Nationality.fromJson(Map<String, dynamic> json) {
    natinalityID = json['NatinalityID'];
    nationalityNameTH = json['NatinalityNameTH'];
    nationalityNameENG = json['NatinalityNameENG'];
    thSorting = json['TH_Sorting'];
    engSorting = json['ENG_Sorting'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['NatinalityID'] = natinalityID;
    json['NatinalityNameTH'] = nationalityNameTH;
    json['NatinalityNameENG'] = nationalityNameENG;
    json['TH_Sorting'] = thSorting;
    json['ENG_Sorting'] = engSorting;
    return json;
  }
}

class OrderPriceSetting {
  int id;
  int archiveDocumentType;
  int orderingTypeID;
  int orderingOutPutFormatID;
  String priceSettingName;
  String priceSettingDetail;
  double priceTH;
  double priceForeign;
}

class Province {
  String provinceCode;
  String provinceShortNameTH;
  String provinceNameTH;
  String provinceShortNameENG;
  String provinceNameENG;

  Province.formJson(Map<String, dynamic> json) {
    provinceCode = json['ProvinceCode'];
    provinceShortNameTH = json['ProvinceShortNameTH'];
    provinceNameTH = json['ProvinceNameTH'];
    provinceShortNameENG = json['ProvinceShortNameENG'];
    provinceNameENG = json['ProvinceNameENG'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['ProvinceCode'] = provinceCode;
    json['ProvinceShortNameTH'] = provinceShortNameTH;
    json['ProvinceNameTH'] = provinceNameTH;
    json['ProvinceShortNameENG'] = provinceShortNameENG;
    json['ProvinceNameENG'] = provinceNameENG;
    return json;
  }
}

class District {
  int provinceID;
  String provinceCode;
  String districtCode;
  String districtNameTH;
  String districtNameENG;
  String zipCode;

  District.fromJson(Map<String, dynamic> json) {
    provinceID = json['Province_ID'];
    provinceCode = json['ProvinceCode'];
    districtCode = json['DistrictCode'];
    districtNameTH = json['DistrictNameTH'];
    districtNameENG = json['DistrictNameENG'];
    zipCode = json['ZipCode'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['Province_ID'] = provinceID;
    json['ProvinceCode'] = provinceCode;
    json['DistrictCode'] = districtCode;
    json['DistrictNameTH'] = districtNameTH;
    json['DistrictNameENG'] = districtNameENG;
    json['ZipCode'] = zipCode;
    return json;
  }
}

class SubDistrict {
  int districtID;
  String districtCode;
  String subDistrictCode;
  String subDistrictNameTH;
  String subDistrictNameENG;

  SubDistrict.fromJson(Map<String, dynamic> json) {
    districtID = json['District_ID'];
    districtCode = json['DistrictCode'];
    subDistrictCode = json['SubDistrictCode'];
    subDistrictNameTH = json['SubDistrictNameTH'];
    subDistrictNameENG = json['SubDistrcitNameENG'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['District_ID'] = districtID;
    json['DistrictCode'] = districtCode;
    json['SubDistrictCode'] = subDistrictCode;
    json['SubDistrictNameTH'] = subDistrictNameTH;
    json['SubDistrcitNameENG'] = subDistrictNameENG;
    return json;
  }
}

class Race {
  Race();
  String raceID;
  String raceNameTH;
  String raceNameENG;
  int thSorting;
  int engSorting;

  Race.fromJson(Map<String, dynamic> json) {
    raceID = json['RaceID'];
    raceNameTH = json['RaceNameTH'];
    raceNameENG = json['RaceNameENG'];
    thSorting = json['TH_Sorting'];
    engSorting = json['ENG_Sorting'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['RaceID'] = raceID;
    json['RaceNameTH'] = raceNameTH;
    json['RaceNameENG'] = raceNameENG;
    json['TH_Sorting'] = thSorting;
    json['ENG_Sorting'] = engSorting;
    return json;
  }
}

class Religion {
  Religion();
  String religionID;
  String religionNameTH;
  String religionNameENG;
  int thSorting;
  int engSorting;

  Religion.fromJson(Map<String, dynamic> json) {
    religionID = json['ReligionID'];
    religionNameTH = json['ReligionNameTH'];
    religionNameENG = json['ReligionNameENG'];
    thSorting = json['TH_Sorting'];
    engSorting = json['ENG_Sorting'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['ReligionID'] = religionID;
    json['ReligionNameTH'] = religionNameTH;
    json['ReligionNameENG'] = religionNameENG;
    json['TH_Sorting'] = thSorting;
    json['ENG_Sorting'] = engSorting;
    return json;
  }
}

class ResearchPurpose {
  String purposeID;
  String purposeName;
  String purposeNameENG;
  int thSorting;
  int engSorting;

  ResearchPurpose.fromJson(Map<String, dynamic> json) {
    purposeID = json['PurposeID'];
    purposeName = json['PurposeName'];
    purposeNameENG = json['PurposeNameEng'];
    thSorting = json['TH_Sorting'];
    engSorting = json['ENG_Sorting'];
  }

  Map createjson() {
    Map json = <String, dynamic>{};
    json['PurposeID'] = purposeID;
    json['PurposeName'] = purposeName;
    json['PurposeNameEng'] = purposeNameENG;
    json['TH_Sorting'] = thSorting;
    json['ENG_Sorting'] = engSorting;
    return json;
  }
}

class ResearchTopic {
  String topicID;
  String topicNameTH;
  String topicNameENG;
  int thSorting;
  int engSorting;

  ResearchTopic.fromJson(Map<String, dynamic> json) {
    topicID = json['TopicID'];
    topicNameTH = json['TopicNameTH'];
    topicNameENG = json['TopicNameENG'];
    thSorting = json['TH_Sorting'];
    engSorting = json['ENG_Sorting'];
  }

  Map createJson() {
    Map json = <String, dynamic>{};
    json['TopicID'] = topicID;
    json['TopicNameTH'] = topicNameTH;
    json['TopicNameENG'] = topicNameENG;
    json['TH_Sorting'] = thSorting;
    json['ENG_Sorting'] = engSorting;
    return json;
  }
}
