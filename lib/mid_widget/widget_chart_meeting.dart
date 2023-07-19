import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WidgetChartMeeting extends StatefulWidget {
  const WidgetChartMeeting({super.key});

  @override
  State<WidgetChartMeeting> createState() => WidgetChartMeetingState();
}

class WidgetChartMeetingState extends State<WidgetChartMeeting> {
  bool meetingClicked = false;
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), 3 * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 700,
      color: Colors.white,
      child: LineChart(
        LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(
                border: const Border(
              right: BorderSide(width: 5),
              left: BorderSide(width: 5),
              bottom: BorderSide(width: 5),
            )),
            lineBarsData: [
              // The red line
              LineChartBarData(
                spots: dummyData1,
                isCurved: true,
                barWidth: 5,
                color: Colors.indigo,
              ),
            ],
            backgroundColor: Colors.white),
        duration: Duration(milliseconds: 150), // Optional
        curve: Curves.linear, // Optional
      ),
    );
  }
}
