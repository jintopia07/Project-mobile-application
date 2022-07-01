// @dart=2.9
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:nat/src/Authentication/Models/RequestAuthen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nat/src/Authentication/Models/AuthenticatedUser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/expect.dart';

class AuthenticationService {
  final encoding = Encoding.getByName('utf-8');
  static String currentUserNamePrefKey = "CurrentUserName";
  static String currentRoleNamePrefkey = "RoleName";
  String mainWebAPIURL = "";
  String databasePath = "";
  String databaseName = "nat_mobile_database.db";
  Database database;

  AuthenticationService(this.mainWebAPIURL);

  Future<AuthenticatedUser> authen(String username, String password) async {
    Uri uri = Uri.parse("$mainWebAPIURL/api/authen/authen");
    RequestAuthen requestAuthen = RequestAuthen(username, password);
    var map = requestAuthen.toJson();
    var convertedJson = json.encode(map);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: convertedJson,
        encoding: encoding);
    if (response.statusCode == 200) {
      var returnedBody = response.body;
      var convertedbody = json.decode(returnedBody);
      return AuthenticatedUser.fromJson(convertedbody);
    }
    return null;
  }

  Future<void> saveAuthenticatedUser(
      AuthenticatedUser authenticatedUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userName = authenticatedUser.username;
    var role = authenticatedUser.role;
    prefs.setString(currentUserNamePrefKey, userName);
    prefs.setString(currentRoleNamePrefkey, role);
  }

  static Future<AuthenticatedUser> getAuthenticatedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userName = prefs.getString(currentUserNamePrefKey);
    var roleName = prefs.getString(currentRoleNamePrefkey);
    if (userName != null && roleName != null) {
      AuthenticatedUser authenticatedUser =
          AuthenticatedUser(username: userName, role: roleName);
      return authenticatedUser;
    } else {
      return null;
    }
  }

  static Future<void> clearAuthenticatedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(currentUserNamePrefKey);
    await prefs.remove(currentRoleNamePrefkey);
  }
}
