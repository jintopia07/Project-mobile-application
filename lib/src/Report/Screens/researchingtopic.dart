// @dart=2.9
import 'package:flutter/material.dart';

class ReSearchingTopic extends StatefulWidget {
  const ReSearchingTopic({ Key key }) : super(key: key);

  @override
  _ReSearchingTopicState createState() => _ReSearchingTopicState();
}

class _ReSearchingTopicState extends State<ReSearchingTopic> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('สถิติการค้นคว้า'),
          backgroundColor: Colors.teal[600],
        ),
      ),
    );
  }
}
