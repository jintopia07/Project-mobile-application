import 'package:flutter/material.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/src/Searching/Models/AdvanceSearchStructure.dart';
import 'package:nat/src/Searching/Models/BasicSearchStructure.dart';
import 'package:nat/src/Searching/Models/ISearchStructure.dart';
import 'package:nat/src/Searching/Services/AdvanceSearch.dart';
import 'package:nat/src/Searching/Services/BasicSearch.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class NATSearcher {
  String mainWebAPIUrl;
  ISearchStructure? isearchStructure;
  bool isSearchByBasicSearchStructure = false;
  BasicSearchStructure? _basicSearchStructure;
  bool isSearchByAdvanceSearchStructure = false;
  AdvanceSearchStructure? _advanceSearchStructure;

  ArchivesDataQuantity? searchedArchivesDataQuantity;

  NATSearcher(this.mainWebAPIUrl);

  void SetSearchStructure(ISearchStructure searchStructure) {
    isearchStructure = searchStructure;
    if (searchStructure is BasicSearchStructure) {
      isSearchByBasicSearchStructure = true;
      isSearchByAdvanceSearchStructure = false;
      _basicSearchStructure = searchStructure;
    } else if (searchStructure is AdvanceSearchStructure) {
      isSearchByAdvanceSearchStructure = true;
      isSearchByBasicSearchStructure = false;
      _advanceSearchStructure = searchStructure;
    }
  }

  Future<ArchivesDataQuantity>? getArchivesDataQuantity() {
    if (isSearchByBasicSearchStructure) {
      BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
      return basicSearch
          .getArchivesDataQuantity(_basicSearchStructure)
          .then((value) => searchedArchivesDataQuantity = value);
    } else if (isSearchByAdvanceSearchStructure) {
      AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);
      return advanceSearch
          .getArchivesDataQuantity(_advanceSearchStructure)
          .then((value) => searchedArchivesDataQuantity = value);
    }
    return null;
  }

  Future<int>? countPaper() {
    if (isSearchByBasicSearchStructure) {
      BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
      return basicSearch.countPaper(_basicSearchStructure);
    } else if (isSearchByAdvanceSearchStructure) {
      AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);
      return advanceSearch.countPaper(_advanceSearchStructure);
    }
    return null;
  }

  Future<int>? countImage() {
    if (isSearchByBasicSearchStructure) {
      BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
      return basicSearch.countImage(_basicSearchStructure);
    } else if (isSearchByAdvanceSearchStructure) {
      AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);
      return advanceSearch.countImage(_advanceSearchStructure);
    }
    return null;
  }

  Future<int>? countMap() {
    if (isSearchByBasicSearchStructure) {
      BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
      return basicSearch.countMap(_basicSearchStructure);
    } else if (isSearchByAdvanceSearchStructure) {
      AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);
      return advanceSearch.countMap(_advanceSearchStructure);
    }
    return null;
  }

  Future<int>? countVideo() {
    if (isSearchByBasicSearchStructure) {
      BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
      return basicSearch.countVideo(_basicSearchStructure);
    } else if (isSearchByAdvanceSearchStructure) {
      AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);
      return advanceSearch.countVideo(_advanceSearchStructure);
    }
    return null;
  }

  Future<int>? countSound() {
    if (isSearchByBasicSearchStructure) {
      BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
      return basicSearch.countSound(_basicSearchStructure);
    } else if (isSearchByAdvanceSearchStructure) {
      AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);
      return advanceSearch.countSound(_advanceSearchStructure);
    }
    return null;
  }

  Future<List<Content>>? searchPapers() {
    if (isSearchByBasicSearchStructure) {
      BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
      return basicSearch.searchPaper(_basicSearchStructure);
    } else if (isSearchByAdvanceSearchStructure) {
      AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);
      return advanceSearch.searchPaper(_advanceSearchStructure);
    }
    return null;
  }

  Future<List<DigitalFile>>? searchImages() {
    if (isSearchByBasicSearchStructure) {
      BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
      return basicSearch.searchImage(_basicSearchStructure);
    } else if (isSearchByAdvanceSearchStructure) {
      AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);
      return advanceSearch.searchImage(_advanceSearchStructure);
    }
    return null;
  }

  Future<List<DigitalFile>>? searchMaps() {
    if (isSearchByBasicSearchStructure) {
      BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
      return basicSearch.searchMap(_basicSearchStructure);
    } else if (isSearchByAdvanceSearchStructure) {
      AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);
      return advanceSearch.searchMap(_advanceSearchStructure);
    }
    return null;
  }

  Future<List<DigitalFile>>? searchVideos() {
    if (isSearchByBasicSearchStructure) {
      BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
      return basicSearch.searchVideo(_basicSearchStructure);
    } else if (isSearchByAdvanceSearchStructure) {
      AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);
      return advanceSearch.searchVideo(_advanceSearchStructure);
    }
    return null;
  }

  Future<List<DigitalFile>>? searchSounds() {
    if (isSearchByBasicSearchStructure) {
      BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
      return basicSearch.searchSound(_basicSearchStructure);
    } else if (isSearchByAdvanceSearchStructure) {
      AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);
      return advanceSearch.searchSound(_advanceSearchStructure);
    }
    return null;
  }

  Future<List<Content>>? getNearestContents(Content content) async {
    String contentOid = content.oid;
    Uri uri =
        Uri.parse("$mainWebAPIUrl/api/searcher/GetNearestContents/$contentOid");
    var response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
    );
    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => Content.fromJson(e)).toList();
    return results;
  }

  Future<List<DigitalFile>>? getNearestDigitalFiles(
      DigitalFile digitalFile) async {
    String digitalFileOid = digitalFile.oid;
    Uri uri = Uri.parse(
        "$mainWebAPIUrl/api/searcher/GetNearestDigitalFiles/$digitalFileOid");
    var response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
    );
    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => DigitalFile.fromJson(e)).toList();
    return results;
  }
}
