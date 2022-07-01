// @dart=2.9
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:nat/src/Report/Models/grades_data.dart';

class PieChart extends StatelessWidget {
  PieChart({Key key}) : super(key: key);

  final data = [
    GradesData('A', 190),
    GradesData('B', 230),
    GradesData('C', 150),
    GradesData('D', 73),
    GradesData('E', 31),
    GradesData('Fail', 13),
  ];

  _getSeriesData() {
    List<charts.Series<GradesData, String>> series = [
      charts.Series(
          id: "Grades",
          data: data,
          labelAccessorFn: (GradesData row, _) =>
              '${row.gradeSymbol}: ${row.numberOfStudents}',
          domainFn: (GradesData grades, _) => grades.gradeSymbol,
          measureFn: (GradesData grades, _) => grades.numberOfStudents)
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Pie Chart"),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    "สถิติการทำสำเนา",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: charts.PieChart(
                      _getSeriesData(),
                      animate: true,
                      defaultRenderer: charts.ArcRendererConfig(
                          arcWidth: 60,
                          arcRendererDecorators: [
                            charts.ArcLabelDecorator()
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
