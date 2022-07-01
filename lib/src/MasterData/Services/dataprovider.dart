// @dart=2.9
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nat/src/MasterData/Models/MasterData.dart';

class DataProvider {
  String mainWebAPIURL;

  DataProvider(this.mainWebAPIURL);

  Future<List<NATBranch>> getNATBranches() async {
    List<NATBranch> branchses = <NATBranch>[];
    var reponse = await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/NATbranch'));
    if (reponse.statusCode == 200) {
      Iterable jsonDecoded = json.decode(reponse.body);
      branchses = jsonDecoded.map((b) => NATBranch.fromJson(b)).toList();
    }
    return branchses;
  }

  Future<List<BankInfo>> getBankInfoes() async {
    List<BankInfo> bankInfoes = <BankInfo>[];
    var response = await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/bankinfo'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      bankInfoes = jsonDecoded.map((b) => BankInfo.fromJson(b)).toList();
    }
    return bankInfoes;
  }

  Future<List<PaymentSolution>> getPaymentSolutions() async {
    List<PaymentSolution> paymentSolutions = <PaymentSolution>[];
    var response =
        await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/PaymentSolution'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      paymentSolutions =
          jsonDecoded.map((b) => PaymentSolution.fromJson(b)).toList();
    }
    return paymentSolutions;
  }

  Future<List<TitleName>> getTitleNames() async {
    List<TitleName> titleNames = <TitleName>[];
    var response = await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/Titlename'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      titleNames = jsonDecoded.map((t) => TitleName.fromJson(t)).toList();
    }
    return titleNames;
  }

  Future<List<Career>> getCareers() async {
    List<Career> careers = <Career>[];
    var response = await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/Career'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      careers = jsonDecoded.map((c) => Career.fromJson(c)).toList();
    }
    return careers;
  }

  Future<List<EducationField>> getEducationFields() async {
    List<EducationField> educationFiels = <EducationField>[];
    var response =
        await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/EducationField'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      educationFiels =
          jsonDecoded.map((ed) => EducationField.fromJson(ed)).toList();
    }
    return educationFiels;
  }

  Future<List<EducationLevel>> getEducationLevels() async {
    List<EducationLevel> educationLevels = <EducationLevel>[];
    var response =
        await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/EducationLevel'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      educationLevels =
          jsonDecoded.map((el) => EducationLevel.fromJson(el)).toList();
    }
    return educationLevels;
  }

  Future<List<Nationality>> getNationalities() async {
    List<Nationality> nationalities = <Nationality>[];
    var response =
        await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/Nationality'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      nationalities = jsonDecoded.map((n) => Nationality.fromJson(n)).toList();
    }
    return nationalities;
  }

  Future<List<Province>> getProvinces() async {
    List<Province> provinces = <Province>[];
    var response = await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/Province'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      provinces = jsonDecoded.map((p) => Province.formJson(p)).toList();
    }
    return provinces;
  }

  Future<List<District>> getDistricts(String provinceCode) async {
    List<District> districts = <District>[];
    var response = await http
        .get(Uri.parse('$mainWebAPIURL/api/masterdata/district/$provinceCode'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      districts = jsonDecoded.map((d) => District.fromJson(d)).toList();
    }
    return districts;
  }

  Future<List<SubDistrict>> getSubDistricts(String districtCode) async {
    List<SubDistrict> subDistricts = <SubDistrict>[];
    var response = await http
        .get(Uri.parse('$mainWebAPIURL/api/masterdata/subdistrict/$districtCode'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      subDistricts = jsonDecoded.map((sd) => SubDistrict.fromJson(sd)).toList();
    }
    return subDistricts;
  }

  Future<List<Race>> getRaces() async {
    List<Race> races = <Race>[];
    var response = await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/race'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      races = jsonDecoded.map((r) => Race.fromJson(r)).toList();
    }
    return races;
  }

  Future<List<Religion>> getReligions() async {
    List<Religion> religions = <Religion>[];
    var response = await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/religion'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      religions = jsonDecoded.map((r) => Religion.fromJson(r)).toList();
    }
    return religions;
  }

  Future<List<ResearchPurpose>> getResearchPurposes() async {
    List<ResearchPurpose> researchPurposes = <ResearchPurpose>[];
    var response =
        await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/researchpurpose'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      researchPurposes =
          jsonDecoded.map((rp) => ResearchPurpose.fromJson(rp)).toList();
    }
    return researchPurposes;
  }

  Future<List<ResearchTopic>> getResearchTopic() async {
    List<ResearchTopic> researchTopics = <ResearchTopic>[];
    var response =
        await http.get(Uri.parse('$mainWebAPIURL/api/masterdata/researchtopic'));
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      researchTopics =
          jsonDecoded.map((tp) => ResearchTopic.fromJson(tp)).toList();
    }
    return researchTopics;
  }
}