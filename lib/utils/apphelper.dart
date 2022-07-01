// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/Config/WebSite_Config.dart';
import 'package:nat/src/EmployeeProfile/Models/Employee.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:nat/widgets/customdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppHelper {
  static Future<String> getCurrentMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('MemberCardID');
  }

  static Future clearCurrentMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('MemberCardID');
  }

  static Future keepCurrentMember(String cardID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('MemberCardID', cardID);
  }

  static Future<String> getCurrentEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('EmployeeUsername');
  }

  static Future clearCurrentEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('EmployeeUsername');
  }

  static Future keepCurrentEmployee(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('EmployeeUsername', username);
  }

  static Future<Employee> getEmployeeData(
      String username, String password) async {
    List<Employee> employees = <Employee>[];
    Employee empResult;
    DataProvider dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
    await dataProvider.getNATBranches().then((b) {
      employees = b
          .map((branchData) => Employee(
              userName: branchData.branchID.toLowerCase(),
              password: branchData.branchID.toLowerCase(),
              branchName: branchData.branchNameTH,
              displayName: 'เจ้าหน้าที่ ${branchData.branchNameTH}'))
          .toList();
      if (employees
          .where((emp) =>
              ((emp.userName == username) && (emp.password == password)))
          .isNotEmpty) {
        empResult = employees
            .where((emp) =>
                ((emp.userName == username) && (emp.password == password)))
            .first;
      }
    });
    return empResult;
  }

  static Future<ConfirmAction> alertConfirmDialog(
      BuildContext context, String titleMessage, String contentMessage) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(titleMessage),
          content: Text(contentMessage),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // background
              ),
              child: Text(
                'Accecpt',
                style: TextStyle(color: Colors.teal[600]),
              ),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            ),
            SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // background
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
