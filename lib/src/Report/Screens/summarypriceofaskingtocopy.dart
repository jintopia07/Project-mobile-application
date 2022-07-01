// @dart=2.9
import 'package:flutter/material.dart';

class SummaryPriceofAskingtoCopy extends StatefulWidget {
  const SummaryPriceofAskingtoCopy({ Key key }) : super(key: key);

  @override
  _SummaryPriceofAskingtoCopyState createState() => _SummaryPriceofAskingtoCopyState();
}

class _SummaryPriceofAskingtoCopyState extends State<SummaryPriceofAskingtoCopy> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('สถิติการค่าบริการทำสำเนาออนไลน์'),
          backgroundColor: Colors.teal[600],
        ),
      ),
    );
  }
}
