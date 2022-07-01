// @dart=2.9
import 'package:flutter/material.dart';

class SummaryPaidofarchiveData extends StatefulWidget {
  const SummaryPaidofarchiveData({Key key}) : super(key: key);

  @override
  _SummaryPaidofarchiveDataState createState() => _SummaryPaidofarchiveDataState();
}

class _SummaryPaidofarchiveDataState extends State<SummaryPaidofarchiveData> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('สถิติการขอทำสำเนาที่ชำระเงินแล้ว'),
          backgroundColor: Colors.teal[600],
        ),
      ),
    );
  }
}

