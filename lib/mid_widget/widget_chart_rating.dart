import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WidgetChartRating extends StatefulWidget {
  const WidgetChartRating({super.key});

  @override
  State<WidgetChartRating> createState() => WidgetChartRatingState();
}

class WidgetChartRatingState extends State<WidgetChartRating> {
  bool ratingClicked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 700,
      color: Colors.white,
      child: BarChart(BarChartData(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          borderData: FlBorderData(
              border: const Border(
            right: BorderSide(width: 5),
            left: BorderSide(width: 5),
            bottom: BorderSide(width: 5),
          )),
          groupsSpace: 10,
          gridData: FlGridData(show: false),
          // add bars
          barGroups: [
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(toY: 10, width: 15, color: Colors.indigo),
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(toY: 9, width: 15, color: Colors.indigo),
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(toY: 4, width: 15, color: Colors.indigo),
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(toY: 2, width: 15, color: Colors.indigo),
            ]),
            BarChartGroupData(x: 5, barRods: [
              BarChartRodData(toY: 12, width: 15, color: Colors.indigo),
            ]),
            BarChartGroupData(x: 6, barRods: [
              BarChartRodData(toY: 10, width: 15, color: Colors.indigo),
            ]),
            BarChartGroupData(x: 7, barRods: [
              BarChartRodData(toY: 19, width: 15, color: Colors.indigo),
            ]),
            BarChartGroupData(x: 8, barRods: [
              BarChartRodData(toY: 18, width: 15, color: Colors.indigo),
            ]),
          ])),
    );
  }
}
