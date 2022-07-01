// @dart=2.9
import 'package:http/http.dart';
import 'package:nat/src/MemberOrder/Models/CheckedoutOrder.dart';
import 'package:nat/src/MemberOrder/Models/Order.dart';
import 'package:nat/src/MemberOrder/Models/RequestOrdersStructure.dart';
import 'package:nat/src/MemberOrder/Models/SelectedDigitalFileToOrder.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MemberOrderingService {
  final encoding = Encoding.getByName('utf-8');
  MemberOrderingService(this.mainWebAPIUrl, this.memberCardID);

  String mainWebAPIUrl;
  String memberCardID;

  Future<Response> postSelectedDigitalFile(
      String memberCardID, DigitalFile digitalFile) async {
    String digitalFileOid = digitalFile.oid;
    SelectedDigitalFileToOrder digitalFileToOrder =
        SelectedDigitalFileToOrder();
    digitalFileToOrder.cardID = memberCardID;
    digitalFileToOrder.digitalFileOid = digitalFileOid;
    Uri uri =
        Uri.parse("$mainWebAPIUrl/api/memberordering/postselecteddigitalfile");
    var data = digitalFileToOrder.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    return response;
  }

  void checkOut(CheckoutOrder checkoutOrder) async {
    Uri uri = Uri.parse("$mainWebAPIUrl/api/memberordering/checkout");
    var data = checkoutOrder.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    if (response.statusCode == 200) {}
  }

  Future<List<Order>> getDraftOrders() async {
    Uri uri = Uri.parse("$mainWebAPIUrl/api/memberordering/draftorders");
    RequestOrdersStructure requestOrdersStructure = RequestOrdersStructure();
    requestOrdersStructure.cardID = memberCardID;
    var data = requestOrdersStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    Iterable iterableOrders = json.decode(response.body);
    var result = iterableOrders.map((e) => Order.fromJson(e)).toList();
    return result;
  }

  Future<List<Order>> getWaitingForApprovalOrders() async {
    Uri uri =
        Uri.parse("$mainWebAPIUrl/api/memberordering/waitingforapprovalorders");
    RequestOrdersStructure requestOrdersStructure = RequestOrdersStructure();
    requestOrdersStructure.cardID = memberCardID;
    var data = requestOrdersStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    Iterable iterableOrders = json.decode(response.body);
    var result = iterableOrders.map((e) => Order.fromJson(e)).toList();
    return result;
  }

  Future<List<Order>> getReadyToPayOrders(
      [int pageNumber, int maxRowPerPage]) async {
    Uri uri = Uri.parse("$mainWebAPIUrl/api/memberordering/readytopayorders");
    List<Order> ordersResult = List<Order>.empty();
    RequestOrdersStructure requestOrdersStructure = RequestOrdersStructure();
    requestOrdersStructure.cardID = memberCardID;

    if (pageNumber != 0 && maxRowPerPage != 0) {
      requestOrdersStructure.pageNumber = pageNumber;
      requestOrdersStructure.maxRowPerPage = maxRowPerPage;
    }
    var data = requestOrdersStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    if (response.statusCode == 200) {
      Iterable iterableOrders = json.decode(response.body);
      ordersResult = iterableOrders.map((e) => Order.fromJson(e)).toList();
    }
    return ordersResult;
  }

  Future<List<Order>> getPaidOrders() async {
    Uri uri = Uri.parse("$mainWebAPIUrl/api/memberordering/paidorders");
    RequestOrdersStructure requestOrdersStructure = RequestOrdersStructure();
    requestOrdersStructure.cardID = memberCardID;
    var data = requestOrdersStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    Iterable iterableOrders = json.decode(response.body);
    var result = iterableOrders.map((e) => Order.fromJson(e)).toList();
    return result;
  }

  Future<List<Order>> getCompltedDownloadingOrders() async {
    Uri uri = Uri.parse(
        "$mainWebAPIUrl/api/memberordering/CompletedDownloadingOrders");
    RequestOrdersStructure requestOrdersStructure = RequestOrdersStructure();
    requestOrdersStructure.cardID = memberCardID;
    var data = requestOrdersStructure.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    Iterable iterableOrders = json.decode(response.body);
    var result = iterableOrders.map((e) => Order.fromJson(e)).toList();
    return result;
  }
}
