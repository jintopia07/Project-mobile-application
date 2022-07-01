// @dart=2.9
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:nat/src/EmployeeOrder/Models/ConsiderOrderDetail.dart';
import 'package:nat/src/EmployeeOrder/Models/RequestOrderDetails.dart';
import 'package:nat/src/MemberOrder/Models/OrderDetail.dart';

class EmployeeOrderingService {
  String mainWebAPIURL;
  final encoding = Encoding.getByName('utf-8');
  EmployeeOrderingService(this.mainWebAPIURL);

  Future<String> postConsideredOrderDetail(
      ConsiderOrderDetail considerOrderDetail) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/employeeordering/ConsiderOrderDetail");

    var data = considerOrderDetail.createJson();
    var convertedData = json.encode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    if (response.statusCode == 200) {}
    var returnData = json.decode(response.body);
    return returnData;
  }

  Future<List<OrderDetail>> getOrderDetailsToApprove(
      RequestOrderDetails requestOrderDetails) async {
    Uri uri = Uri.parse(
        "$mainWebAPIURL/api/employeeordering/OrderDetailsToApprove");

    var data = requestOrderDetails.createJson();
    var convertedData = jsonEncode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    Iterable iterableOrders = jsonDecode(response.body);
    var results = iterableOrders.map((e) => OrderDetail.fromJson(e)).toList();
    return results;
  }

  Future<List<OrderDetail>> getConsideredOrderDetails(
      RequestOrderDetails requestOrderDetails) async {
    Uri uri = Uri.parse(
        "$mainWebAPIURL/api/employeeordering/ConsideredOrderDetails");

    var data = requestOrderDetails.createJson();
    var convertedData = jsonEncode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    Iterable iterableOrders = jsonDecode(response.body);
    var results = iterableOrders.map((e) => OrderDetail.fromJson(e)).toList();
    return results;
  }

  Future<List<OrderDetail>> getPaidOrderDetails(
      RequestOrderDetails requestOrderDetails) async {
    Uri uri =
        Uri.parse("$mainWebAPIURL/api/employeeordering/PaidOrderDetails");

    var data = requestOrderDetails.createJson();
    var convertedData = jsonEncode(data);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedData,
        encoding: encoding);
    Iterable iterableOrders = jsonDecode(response.body);
    var results = iterableOrders.map((e) => OrderDetail.fromJson(e)).toList();
    return results;
  }
}
