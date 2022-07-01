// @dart=2.9
import 'package:flutter/material.dart';

import 'employee_unapproved_order.dart';
import 'employeeapprovedorder.dart';

class EmployeeForApprovedOrder extends StatefulWidget {
  const EmployeeForApprovedOrder({Key key}) : super(key: key);

  @override
  State<EmployeeForApprovedOrder> createState() =>
      _EmployeeForApprovedOrderState();
}

class _EmployeeForApprovedOrderState extends State<EmployeeForApprovedOrder> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('รายการที่อนุมัติเรียบร้อย'),
          backgroundColor: Colors.teal[600],
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.brown[400],
            indicatorWeight: 5,
            labelColor: Colors.lightBlueAccent[600],
            unselectedLabelColor: Colors.grey[500],
            tabs: [
              Tab(icon: const Icon(Icons.check), text: 'อนุมัติ'),
              Tab(icon: const Icon(Icons.sync_problem), text: 'ไม่อนุมัติ'),
            ],
          ),
        ),
        body: TabBarView(
          children: const [
            EmployeeApprovedOrder(),
            EmployeeUnApprovedOrder(),
          ],
        ),
      ),
    );
  }
}
