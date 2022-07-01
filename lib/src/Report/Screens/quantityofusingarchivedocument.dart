// @dart=2.9
import 'package:flutter/material.dart';

class QuantityofusingarchiveDocument extends StatefulWidget {
  const QuantityofusingarchiveDocument({Key key}) : super(key: key);

  @override
  _QuantityofusingarchiveDocumentState createState() =>
      _QuantityofusingarchiveDocumentState();
}

class _QuantityofusingarchiveDocumentState
    extends State<QuantityofusingarchiveDocument> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('สถิติด้านเอกสารแต่ละประเภท'),
          backgroundColor: Colors.teal[600],
        ),
      ),
    );
  }
}
