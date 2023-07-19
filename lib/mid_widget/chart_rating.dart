import 'package:flutter/material.dart';
import 'widget_chart_rating.dart';

class ChartRating extends StatefulWidget {
  const ChartRating({super.key});

  @override
  State<ChartRating> createState() => ChartRatingState();
}

class ChartRatingState extends State<ChartRating> {
  bool ratingClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () {
          Navigator.pop(context);
        },
        child: Scaffold(body: WidgetChartRating()));
  }
}
