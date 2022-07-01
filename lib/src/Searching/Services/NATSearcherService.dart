// @dart=2.9
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/Config/WebSite_Config.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';
import 'dart:convert';

import 'package:nat/src/Searching/Models/ArchiveInfo.dart';

class NATSearcherService {
  String mainWebAPIURL = WebAPI_Config.mainWebAPIURL;
  AccountTypeShortName selectedAccountType;
  String searchingKeyword;
  SearchingOptions searchingOption;
  int maxRowPerPage;
  int currentPageNumber;
  int quantityOfSearching;
  String selectedBranchIDs;
  List<NATBranch> selectedBranches;

  List<Content> searchedContents;
  List<DigitalFile> searchedDigitalfiles;

  //NAT branches note.
  //NAT01 : สำนักหอจดหมายเหตุแห่งชาติ
  //NAT02 : หอจดหมายเหตุแห่งชาติเฉลิมพระเกียรติฯ ร.9
  //NAT03 : หอจดหมายเหตุแห่งชาติ จังหวัดจันทบุรี
  //NAT04 : หอจดหมายเหตุแห่งชาติเฉลิมพระเกียรติฯ  ตรัง
  //NAT05 : หอจดหมายเหตุแห่งชาติเฉลิมพระเกียรติฯ สงขลา
  //NAT06 : หอจดหมายเหตุแห่งชาติเฉลิมพระเกียรติฯ อุบลราชธานี
  //NAT07 : หอจดหมายเหตุแห่งชาติ จังหวัดสุพรรณบุรี
  //NAT08 : หอจดหมายเหตุนายกรัฐมนตรี พลเอก เปรม ติณสูลานนท์
  //NAT09 : หอจดหมายเหตุแห่งชาติเฉลิมพระเกียรติฯ พะเยา

  NATSearcherService(this.mainWebAPIURL) {
    selectedAccountType = AccountTypeShortName.Peper;
    searchingOption = SearchingOptions.Phase;
    searchingKeyword = '';
    maxRowPerPage = 25;
    currentPageNumber = 1;
    selectedBranchIDs = '';
    quantityOfSearching = 0;
    selectedBranches = <NATBranch>[];

    searchedContents = <Content>[];
    searchedDigitalfiles = <DigitalFile>[];
  }

  int getStartRowNumber(int pageNumber) {
    if (pageNumber == 1) {
      return 1;
    }
    return ((maxRowPerPage * pageNumber) - maxRowPerPage) + 1;
  }

  int getEndRowNumber(int pageNumber) {
    return (maxRowPerPage * pageNumber);
  }

  static String getAccountName(AccountTypeShortName accountTypeShortName) {
    switch (accountTypeShortName) {
      case AccountTypeShortName.Peper:
        {
          return "เอกสารจดหมายเหตุลายลักษณ์";
        }
        break;
      case AccountTypeShortName.Image:
        {
          return "เอกสารโสตทัศน-ภาพ";
        }
        break;
      case AccountTypeShortName.VDO:
        {
          return "เอกสารโสตทัศน-แถบบันทึกภาพ";
        }
        break;
      case AccountTypeShortName.Sound:
        {
          return "เอกสารโสตทัศน-แถบบันทึกเสียง";
        }
        break;
      case AccountTypeShortName.MAP:
        {
          return "แผนที่ แผนผัง แบบแปลน";
        }
        break;
    }
    return "";
  }

  static getAccountNameToWorkWithWebAPI(
      AccountTypeShortName accountTypeShortName) {
    switch (accountTypeShortName) {
      case AccountTypeShortName.Peper:
        {
          return "เอกสารจดหมายเหตุลายลักษณ์";
        }
        break;
      case AccountTypeShortName.Image:
        {
          return "เอกสารโสตทัศน-ภาพ";
        }
        break;
      case AccountTypeShortName.VDO:
        {
          return "เอกสารโสตทัศน-แถบภาพเคลื่อนไหว";
        }
        break;
      case AccountTypeShortName.Sound:
        {
          return "เอกสารโสตทัศน-แถบบันทึกเสียง";
        }
        break;
      case AccountTypeShortName.MAP:
        {
          return "เอกสารโสตทัศน-แผนที่";
        }
        break;
    }
    return "";
  }

  static AccountTypeShortName getAccountTypeShortName(String accounttypeName) {
    switch (accounttypeName) {
      case 'เอกสารจดหมายเหตุลายลักษณ์':
        {
          return AccountTypeShortName.Peper;
        }
        break;
      case 'เอกสารโสตทัศน-ภาพ':
        {
          return AccountTypeShortName.Image;
        }
        break;
      case 'เอกสารโสตทัศน-แถบบันทึกภาพ':
        {
          return AccountTypeShortName.VDO;
        }
        break;
      case 'เอกสารโสตทัศน-แถบภาพเคลื่อนไหว':
        {
          return AccountTypeShortName.VDO;
        }
        break;
      case 'เอกสารโสตทัศน-แถบบันทึกเสียง':
        {
          return AccountTypeShortName.Sound;
        }
        break;
      case 'เอกสารโสตทัศน-แผนที่':
        {
          return AccountTypeShortName.MAP;
        }
        break;
      case 'แผนที่ แผนผัง แบบแปลน':
        {
          return AccountTypeShortName.MAP;
        }
        break;
    }
    return null;
  }

  static String getSearchingOptionName(SearchingOptions option) {
    switch (option) {
      case SearchingOptions.Phase:
        {
          return "ค้นหาตามประโยค";
        }
        break;
      case SearchingOptions.AND:
        {
          return "และ";
        }
        break;
      case SearchingOptions.OR:
        {
          return "หรือ";
        }
        break;
    }
    return "";
  }

  String getSearchingOptionNameEng(SearchingOptions option) {
    switch (option) {
      case SearchingOptions.Phase:
        {
          return "Phase";
        }
        break;
      case SearchingOptions.AND:
        {
          return "And";
        }
        break;
      case SearchingOptions.OR:
        {
          return "Or";
        }
    }
    return "";
  }

  static Image getThumbnailImage(DigitalFile digitalFile) {
    if (digitalFile == null) {
      return Image(image: const AssetImage('assets/images/NoImage.png'));
    }
    if (digitalFile.storedPathThumnail.isEmpty ||
        digitalFile.storedPathThumnail == '') {
      return Image(image: const AssetImage('assets/images/NoImage.png'));
    }
    return Image.network(getThumbnailFileURL(digitalFile));
  }

  static String getThumbnailFileURL(DigitalFile digitalFile) {
    return '${WebSite_Config.mainWebSiteURL}/DigitalFiles/${digitalFile.storedPathThumnail}';
  }

  String getSelectedBranchNames() {
    if (selectedBranches.isEmpty) {
      return '';
    }
    List<String> listBranchNames = <String>[];
    for (var b in selectedBranches) {
      listBranchNames.add(b.branchNameTH);
    }
    return listBranchNames.join(',');
  }

  //This method works with listview.builder.
  int searchedItemCount() {
    if (selectedAccountType == AccountTypeShortName.Peper) {
      return searchedContents.length;
    } else {
      return searchedDigitalfiles.length;
    }
  }

  addSelectedBranches(NATBranch branch) {
    if (selectedBranches.where((b) => b.id == branch.id).toList().isEmpty) {
      selectedBranches.add(branch);
    }
  }

  removedSelectedBranches(NATBranch branch) {
    selectedBranches.removeWhere((b) => b.id == branch.id);
  }

  bool isBranchSelected(int branchID) {
    return (selectedBranches.where((b) => b.id == branchID).toList().isNotEmpty);
  }

  Future<int> searchQuantityOfContent() async {
    int resultQuantity = 0;
    Uri uri = Uri.parse('$mainWebAPIURL/api/searcher/content/quantity');
    var response = await http.post(uri, body: {
      'SearchOption': getSearchingOptionNameEng(searchingOption),
      'Keyword': (searchingKeyword != null) ? searchingKeyword : "",
      'BranchNames': getSelectedBranchNames()
    });
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      resultQuantity = jsonDecoded.first;
    }
    return resultQuantity;
  }

  Future<List<Content>> searchContentBySpecificRowRange(
      int startRow, int endRow) async {
    List<Content> searchedContents = <Content>[];
    var reponse = await http
        .post(Uri.parse('$mainWebAPIURL/api/searcher/content'), body: {
      'SearchOption': getSearchingOptionNameEng(searchingOption),
      'Keyword': (searchingKeyword != null) ? searchingKeyword : "",
      'StartRow': startRow.toString(),
      'EndRow': endRow.toString(),
      'BranchNames': getSelectedBranchNames()
    });
    if (reponse.statusCode == 200) {
      Iterable jsonDecoded = json.decode(reponse.body);
      searchedContents =
          jsonDecoded.map((item) => Content.fromJson(item)).toList();
    }
    return searchedContents;
  }

  Future searchQuantityOfDigitalFiles() async {
    int resultQuantity = 0;
    var response = await http.post(
        Uri.parse('$mainWebAPIURL/api/searcher/digitalfile/quantity'),
        body: {
          'SearchOption': getSearchingOptionNameEng(searchingOption),
          'Keyword': (searchingKeyword != null) ? searchingKeyword : "",
          'BranchNames': getSelectedBranchNames(),
          'AccountType': getAccountNameToWorkWithWebAPI(selectedAccountType)
        });
    if (response.statusCode == 200) {
      Iterable jsonDecoded = json.decode(response.body);
      resultQuantity = jsonDecoded.first;
    }
    return resultQuantity;
  }

  Future<List<DigitalFile>> searchDigitalFileBySpecificRowRange(
      int startRow, int endRow) async {
    List<DigitalFile> searchedDigitalFiles = <DigitalFile>[];
    var reponse = await http
        .post(Uri.parse('$mainWebAPIURL/api/searcher/digitalfile'), body: {
      'SearchOption': getSearchingOptionNameEng(searchingOption),
      'Keyword': (searchingKeyword != null) ? searchingKeyword : "",
      'StartRow': startRow.toString(),
      'EndRow': endRow.toString(),
      'BranchNames': getSelectedBranchNames(),
      'AccountType': getAccountNameToWorkWithWebAPI(selectedAccountType)
    });
    if (reponse.statusCode == 200) {
      Iterable jsonDecoded = json.decode(reponse.body);
      searchedDigitalFiles =
          jsonDecoded.map((d) => DigitalFile.fromJson(d)).toList();
    }
    return searchedDigitalFiles;
  }

  Future<bool> loadDataMore() async {
    int startRowNumber = getStartRowNumber(currentPageNumber);
    int endRowNumber = getEndRowNumber(currentPageNumber);
    if (selectedAccountType == AccountTypeShortName.Peper) {
      searchedContents.addAll(
          await searchContentBySpecificRowRange(startRowNumber, endRowNumber));
    } else {
      searchedDigitalfiles.addAll(await searchDigitalFileBySpecificRowRange(
          startRowNumber, endRowNumber));
    }
    currentPageNumber++;
    return true;
  }

  Future<bool> getSearchingQuantity() async {
    if (selectedAccountType == AccountTypeShortName.Peper) {
      quantityOfSearching = await searchQuantityOfContent();
    } else {
      quantityOfSearching = await searchQuantityOfDigitalFiles();
    }
    return true;
  }

  submitSearching() {
    searchedContents = <Content>[];
    searchedDigitalfiles = <DigitalFile>[];
    currentPageNumber = 1;
    loadDataMore();
  }
}

enum AccountTypeShortName { Peper, Image, MAP, VDO, Sound }
enum SearchingOptions { Phase, AND, OR }
