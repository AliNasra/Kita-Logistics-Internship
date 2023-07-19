import 'package:flutter/material.dart';
import 'widget_chart_meeting.dart';

class ChartMeeting extends StatefulWidget {
  const ChartMeeting({super.key});

  @override
  State<ChartMeeting> createState() => ChartMeetingState();
}

class ChartMeetingState extends State<ChartMeeting> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () {
          Navigator.pop(context);
        },
        child: Scaffold(body: WidgetChartMeeting()));
  }
}
