// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/src/Searching/Models/AdvanceSearchStructure.dart';

class AdvanceSearch {
  String mainWebAPIURL;
  AdvanceSearch(this.mainWebAPIURL);

  Future<ArchivesDataQuantity> getArchivesDataQuantity(
      AdvanceSearchStructure advanceSearchStructure) async {
    ArchivesDataQuantity archivesDataQuantity = ArchivesDataQuantity();
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/searcher/advancesearch/getquantity");
    var data = advanceSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);
    var convertedBody = json.decode(response.body);
    archivesDataQuantity = ArchivesDataQuantity.fromJson(convertedBody);

    return archivesDataQuantity;
  }

  Future<List<Content>> searchPaper(
      AdvanceSearchStructure advanceSearchStructure) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/searcher/advancesearch/searchpaper");
    var data = advanceSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => Content.fromJson(e)).toList();
    return results;
  }

  Future<int> countPaper(AdvanceSearchStructure advanceSearchStructure) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/searcher/advancesearch/countpaper");
    var data = advanceSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    int convertedBody = json.decode(response.body);
    return convertedBody;
  }

  Future<List<DigitalFile>> searchImage(
      AdvanceSearchStructure advanceSearchStructure) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/searcher/advancesearch/searchimage");
    var data = advanceSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => DigitalFile.fromJson(e)).toList();
    return results;
  }

  Future<int> countImage(AdvanceSearchStructure advanceSearchStructure) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/searcher/advancesearch/countimage");
    var data = advanceSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    int convertedBody = json.decode(response.body);
    return convertedBody;
  }

  Future<List<DigitalFile>> searchMap(
      AdvanceSearchStructure advanceSearchStructure) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/searcher/advancesearch/searchMap");
    var data = advanceSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => DigitalFile.fromJson(e)).toList();
    return results;
  }

  Future<int> countMap(AdvanceSearchStructure advanceSearchStructure) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/searcher/advancesearch/countimage");
    var data = advanceSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    int convertedBody = json.decode(response.body);
    return convertedBody;
  }

  Future<List<DigitalFile>> searchSound(
      AdvanceSearchStructure advanceSearchStructure) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/searcher/advancesearch/searchsound");
    var data = advanceSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => DigitalFile.fromJson(e)).toList();
    return results;
  }

  Future<int> countSound(AdvanceSearchStructure advanceSearchStructure) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/searcher/advancesearch/countsound");
    var data = advanceSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    int convertedBody = json.decode(response.body);
    return convertedBody;
  }

  Future<List<DigitalFile>> searchVideo(
      AdvanceSearchStructure advanceSearchStructure) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/searcher/advancesearch/searchvideo");
    var data = advanceSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => DigitalFile.fromJson(e)).toList();
    return results;
  }

  Future<int> countVideo(AdvanceSearchStructure advanceSearchStructure) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/searcher/advancesearch/countvideo");
    var data = advanceSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    int convertedBody = json.decode(response.body);
    return convertedBody;
  }
}
