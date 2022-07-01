// @dart=2.9
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:nat/src/Report/Models/sales_data.dart';

class LineChart extends StatelessWidget {
  LineChart({Key key}) : super(key: key);

  // Defining the data
  final data = [
    SalesData(0, 1500000),
    SalesData(1, 1735000),
    SalesData(2, 1678000),
    SalesData(3, 1890000),
    SalesData(4, 1907000),
    SalesData(5, 2300000),
    SalesData(6, 2360000),
    SalesData(7, 1980000),
    SalesData(8, 2654000),
    SalesData(9, 2789070),
    SalesData(10, 3020000),
    SalesData(11, 3245900),
    SalesData(12, 4098500),
    SalesData(13, 4500000),
    SalesData(14, 4456500),
    SalesData(15, 3900500),
    SalesData(16, 5123400),
    SalesData(17, 5589000),
    SalesData(18, 5940000),
    SalesData(19, 6367000),
  ];

  _getSeriesData() {
    List<charts.Series<SalesData, int>> series = [
      charts.Series(
          id: "Sales",
          data: data,
          domainFn: (SalesData series, _) => series.year,
          measureFn: (SalesData series, _) => series.sales,
          colorFn: (SalesData series, _) =>
              charts.MaterialPalette.blue.shadeDefault)
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 550,
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const Text(
                  "สถิติการค้นคว้า",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: charts.LineChart(
                    _getSeriesData(),
                    animate: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
