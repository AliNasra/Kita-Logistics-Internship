import 'package:flutter/material.dart';
import 'widget_chart_review.dart';

class ChartReview extends StatefulWidget {
  const ChartReview({super.key});

  @override
  State<ChartReview> createState() => ChartReviewState();
}

class ChartReviewState extends State<ChartReview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () {
          Navigator.pop(context);
        },
        child: Scaffold(body: WidgetChartReview()));
  }
}
