import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chart_meeting.dart';
import 'chart_review.dart';
import 'chart_rating.dart';
import 'widget_chart_meeting.dart';
import 'widget_chart_review.dart';
import 'widget_chart_rating.dart';

class PortraitStatistics extends StatefulWidget {
  const PortraitStatistics({super.key});

  @override
  State<PortraitStatistics> createState() => PortraitStatisticsState();
}

class PortraitStatisticsState extends State<PortraitStatistics> {
  //bool ratingClicked = false;
  //bool reviewClicked = false;
  //bool meetingClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/portrait_statistics.jpg"),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: 200,
                alignment: Alignment.center,
                child: Text(
                  "Notable statistics:",
                  style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                    shadows: [
                      Shadow(
                          blurRadius: 5.0, // shadow blur
                          color:
                              Color.fromARGB(255, 220, 115, 4), // shadow color
                          offset: Offset(1.0, 1.0))
                    ],
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  )),
                  softWrap: true,
                ),
              ),
              Container(
                height: 350,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  children: [
                    Container(
                        width: 400,
                        height: 300,
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Reviews",
                              style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                shadows: [
                                  Shadow(
                                      blurRadius: 5.0, // shadow blur
                                      color: Color.fromARGB(
                                          255, 220, 115, 4), // shadow color
                                      offset: Offset(1.0, 1.0))
                                ],
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                              softWrap: true,
                            ),
                            GestureDetector(
                              onDoubleTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChartReview()),
                                );
                              },
                              child: Container(
                                  height: 300,
                                  width: 300,
                                  child: WidgetChartReview()),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Number of meetings",
                              style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                shadows: [
                                  Shadow(
                                      blurRadius: 5.0, // shadow blur
                                      color: Color.fromARGB(
                                          255, 220, 115, 4), // shadow color
                                      offset: Offset(1.0, 1.0))
                                ],
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                              softWrap: true,
                            ),
                            GestureDetector(
                              onDoubleTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChartMeeting()),
                                );
                              },
                              child: Container(
                                  height: 300,
                                  width: 300,
                                  child: WidgetChartMeeting()),
                            )
                          ],
                        )),
                    Container(
                        width: 400,
                        height: 300,
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Ratings",
                              style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                shadows: [
                                  Shadow(
                                      blurRadius: 5.0, // shadow blur
                                      color: Color.fromARGB(
                                          255, 220, 115, 4), // shadow color
                                      offset: Offset(1.0, 1.0))
                                ],
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                              softWrap: true,
                            ),
                            GestureDetector(
                              onDoubleTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChartRating()),
                                );
                              },
                              child: Container(
                                  height: 300,
                                  width: 300,
                                  child: WidgetChartRating()),
                            )
                          ],
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
