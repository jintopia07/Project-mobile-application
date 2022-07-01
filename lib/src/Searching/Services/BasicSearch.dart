// @dart=2.9
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/src/Searching/Models/BasicSearchStructure.dart';

class BasicSearch {
  String mainWebAPIURL;
  BasicSearch(this.mainWebAPIURL);

  Future<ArchivesDataQuantity> getArchivesDataQuantity(
      BasicSearchStructure basicSearchStructure) async {
    ArchivesDataQuantity archivesDataQuantity = ArchivesDataQuantity();
    Uri uri = Uri.parse("$mainWebAPIURL/api/searcher/basicsearch/getquantity");
    var data = basicSearchStructure.createJson();
    var convertedData = jsonEncode(data);
    var response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: convertedData);
    var convertedBody = json.decode(response.body);
    archivesDataQuantity = ArchivesDataQuantity.fromJson(convertedBody);
    return archivesDataQuantity;
  }

  Future<List<Content>> searchPaper(
      BasicSearchStructure basicSearchStructure) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/searcher/basicsearch/searchpaper");
    var data = basicSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => Content.fromJson(e)).toList();
    return results;
  }

  Future<int> countPaper(BasicSearchStructure basicSearchStructure) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/searcher/basicsearch/countpaper");
    var data = basicSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    int convertedBody = json.decode(response.body);
    return convertedBody;
  }

  Future<List<DigitalFile>> searchImage(
      BasicSearchStructure basicSearchStructure) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/searcher/basicsearch/searchimage");
    var data = basicSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => DigitalFile.fromJson(e)).toList();
    return results;
  }

  Future<int> countImage(BasicSearchStructure basicSearchStructure) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/searcher/basicsearch/countimage");
    var data = basicSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    int convertedBody = json.decode(response.body);
    return convertedBody;
  }

  Future<List<DigitalFile>> searchMap(
      BasicSearchStructure basicSearchStructure) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/searcher/basicsearch/searchmap");
    var data = basicSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => DigitalFile.fromJson(e)).toList();
    return results;
  }

  Future<int> countMap(BasicSearchStructure basicSearchStructure) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/searcher/basicsearch/countmap");
    var data = basicSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    int convertedBody = json.decode(response.body);
    return convertedBody;
  }

  Future<List<DigitalFile>> searchSound(
      BasicSearchStructure basicSearchStructure) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/searcher/basicsearch/searchsound");
    var data = basicSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => DigitalFile.fromJson(e)).toList();
    return results;
  }

  Future<int> countSound(BasicSearchStructure basicSearchStructure) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/searcher/basicsearch/countsound");
    var data = basicSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    int convertedBody = json.decode(response.body);
    return convertedBody;
  }

  Future<List<DigitalFile>> searchVideo(
      BasicSearchStructure basicSearchStructure) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/searcher/basicsearch/searchvideo");
    var data = basicSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    Iterable convertedBody = json.decode(response.body);
    var results = convertedBody.map((e) => DigitalFile.fromJson(e)).toList();
    return results;
  }

  Future<int> countVideo(BasicSearchStructure basicSearchStructure) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/searcher/basicsearch/countvideo");
    var data = basicSearchStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: convertedData);

    int convertedBody = json.decode(response.body);
    return convertedBody;
  }
}
