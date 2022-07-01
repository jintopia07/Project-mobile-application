// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/constants.dart';
import 'package:nat/widgets/line_chart.dart';


class QuantityofResearcher extends StatefulWidget {
  const QuantityofResearcher({ Key key }) : super(key: key);

  @override
  _QuantityofResearcherState createState() => _QuantityofResearcherState();
}

class _QuantityofResearcherState extends State<QuantityofResearcher> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('สถิติการค้นคว้า'),
          backgroundColor: Colors.teal[600],
        ),
         body: SingleChildScrollView(
          child: Container(
            height: 500,
            padding: const EdgeInsets.all(defaultPadding),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      top: defaultPadding * 2, bottom: defaultPadding * 2),
                  child: LineChart(),
                ),
                const SizedBox(height: defaultPadding * 1.5),
                SectionCard(),
                const SizedBox(
                  height: defaultPadding * 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget SectionCard() => Container(
        padding: const EdgeInsets.symmetric(
          //horizontal: defaultPadding,
          vertical: defaultPadding / 1,
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("สถิติการค้นคว้า :"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: const Text("20 เมษายน 2564 เวลา 01:16"),
            ),
          ],
        ),
      );
}
