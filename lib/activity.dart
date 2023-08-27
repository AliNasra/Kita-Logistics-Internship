import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'login_data.dart';

class activity extends StatefulWidget {
  const activity({super.key});

  @override
  State<activity> createState() => activityState();
}

class activityState extends State<activity> {
  int customizeNotification = 0;
  Map<int, String> dayInWeek = {
    1: "Pzt",
    2: "Sal",
    3: "Çar",
    4: "Per",
    5: "Cum",
    6: "Cmt",
    7: "Paz",
  };
  Map<int, String> monthsInYear = {
    1: "Ocak",
    2: "Şubat",
    3: "Mart",
    4: "Nisan",
    5: "Mayıs",
    6: "Haziran",
    7: "Temmuz",
    8: "Ağustos",
    9: "Eylül",
    10: "Ekim",
    11: "Kasım",
    12: "Aralık"
  };
  Map<dynamic, dynamic> activity = {};
  Map<String, bool> taps = {
    "Detay": true,
    "Dosyalar": false,
    "Notlar": false,
  };
  String selectedTap = "Detay";
  NumberFormat formatter = new NumberFormat("00");

  List<Widget> getTaps(double screenHeight, double screenWidth) {
    List<Widget> tapList = [];
    for (var key in taps.keys) {
      tapList.add(
        GestureDetector(
            onTap: () {
              selectedTap = key;
              for (var tempkey in taps.keys) {
                taps[tempkey] = false;
              }
              taps[key] = true;
              setState(() {});
            },
            child: Container(
              width: screenWidth / 3.8,
              height: screenHeight / 25,
              margin: EdgeInsets.fromLTRB(0, 0, screenWidth / 500, 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: taps[key]!
                      ? Colors.amber
                      : Color.fromARGB(255, 254, 227, 171),
                  borderRadius: BorderRadius.circular(screenHeight / 80)),
              child: Text(
                key,
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: taps[key]! ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: screenHeight / 50)),
                softWrap: false,
              ),
            )),
      );
    }
    return tapList;
  }

  List<Widget> getParticipants() {
    List<Widget> tapList = [];
    return tapList;
  }

  Widget build(BuildContext context) {
    final params = ((ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map);
    activity = {...params["activity"]};
    ScrollController _scrollController = ScrollController();
    double tempHeight = MediaQuery.of(context).size.height;
    double tempWidth = MediaQuery.of(context).size.width;
    double screenHeight =
        (MediaQuery.of(context).orientation == Orientation.portrait
            ? tempHeight
            : tempWidth);
    double screenWidth = tempWidth;

    return Scaffold(
        body: Container(
            child: Column(children: [
      Container(
        color: Colors.amber,
        padding: EdgeInsets.fromLTRB(
            screenWidth / 100, screenHeight / 20, screenWidth / 100, 0),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: MemoryImage(
                          Provider.of<LoginData>(context, listen: false)
                              .profileImage) as ImageProvider?,
                      radius: screenHeight / 30,
                    ),
                  ),
                ],
              ),
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                padding: EdgeInsets.only(left: screenWidth / 25),
                child: Stack(
                  children: [
                    Container(
                      height: screenHeight / 5,
                      width: screenWidth / 5,
                      child: Image.asset(
                        "assets/calendar.png",
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth / 18, screenHeight / 11.5, 0, 0),
                      child: Text(
                          "${dayInWeek[DateTime.parse(activity["startDate"]).weekday]}\n${DateTime.parse(activity["startDate"]).day}\n${DateTime.parse(activity["startDate"]).year}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: screenHeight / 50))),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: screenWidth / 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${activity["companyID"]}",
                          softWrap: false,
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: screenHeight / 45))),
                      Text("Potansiyel Müşteri",
                          softWrap: false,
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: screenHeight / 55)))
                    ],
                  )),
            ]),
          ],
        ),
      ),
      Container(
        height: screenHeight / 2.4,
        padding: EdgeInsets.fromLTRB(
            screenWidth / 20, screenHeight / 80, screenWidth / 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: screenHeight / 100),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: getTaps(screenHeight, screenWidth)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: screenHeight / 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Katılımcılar",
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: screenHeight / 35))),
                ],
              ),
            ),
            Container(
              height: screenHeight / 15,
              child: Row(children: getParticipants()),
            ),
            Container(
                margin: EdgeInsets.only(bottom: screenHeight / 40),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: screenWidth / 10),
                      child: Icon(Icons.access_time,
                          size: screenHeight / 30, color: Colors.amber),
                    ),
                    Container(
                        child: Text(
                      "${formatter.format(DateTime.parse(activity["startDate"]).hour)}:${formatter.format(DateTime.parse(activity["startDate"]).minute)} - ${formatter.format(DateTime.parse(activity["endDate"]).hour)}:${formatter.format(DateTime.parse(activity["endDate"]).minute)}",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight / 35)),
                    )),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(bottom: screenHeight / 40),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: screenWidth / 10),
                      child: Icon(Icons.calendar_month_outlined,
                          size: screenHeight / 30, color: Colors.amber),
                    ),
                    Container(
                      width: screenWidth / 1.4,
                      height: screenHeight / 30,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                            child: Text(
                          "${dayInWeek[DateTime.parse(activity["startDate"]).weekday]} ${DateTime.parse(activity["startDate"]).day} ${monthsInYear[DateTime.parse(activity["startDate"]).month]}, ${DateTime.parse(activity["startDate"]).year}",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight / 35)),
                        )),
                      ),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(bottom: screenHeight / 40),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: screenWidth / 10),
                      child: Icon(Icons.location_on,
                          size: screenHeight / 30, color: Colors.amber),
                    ),
                    Container(
                      width: screenWidth / 1.4,
                      height: screenHeight / 30,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                            child: Text(
                          "${activity["location"]}",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight / 35)),
                        )),
                      ),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(bottom: screenHeight / 40),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: screenWidth / 10),
                      child: Icon(Icons.turned_in_rounded,
                          size: screenHeight / 30, color: Colors.amber),
                    ),
                    Container(
                      width: screenWidth / 1.4,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                            height: screenHeight / 30,
                            child: Text(
                              "${activity["note"]}",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenHeight / 40)),
                            )),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      Container(
          padding: EdgeInsets.fromLTRB(
              screenWidth / 20, screenHeight / 50, screenWidth / 20, 0),
          height: screenHeight / 3.75,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromARGB(255, 255, 211, 87),
                  Color.fromARGB(255, 255, 154, 78),
                ],
              ),
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(screenHeight / 80))),
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Container(
                height: screenHeight / 10,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: Column(children: [
                        Text(
                          "Öncelik",
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w900,
                                  fontSize: screenHeight / 28)),
                          softWrap: true,
                        ),
                        Row(children: [
                          GestureDetector(
                            child: Icon(Icons.circle, color: Colors.black),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Icon(Icons.circle, color: Colors.yellow),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Icon(Icons.circle, color: Colors.red),
                            onTap: () {},
                          )
                        ])
                      ])),
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Text(
                              "Hatırlat",
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w900,
                                      fontSize: screenHeight / 28)),
                              softWrap: true,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: screenHeight / 25,
                                  child: ToggleSwitch(
                                    minWidth: screenWidth / 5,
                                    cornerRadius: screenHeight / 100,
                                    activeBgColors: [
                                      [Colors.red],
                                      [Colors.green]
                                    ],
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Colors.grey,
                                    inactiveFgColor: Colors.white,
                                    initialLabelIndex: customizeNotification,
                                    totalSwitches: 2,
                                    labels: ['Hayır', 'Evet'],
                                    radiusStyle: true,
                                    onToggle: (index) {
                                      customizeNotification = index!;
                                      setState(() {});
                                      if (index == 0) {
                                        _scrollController.animateTo(0,
                                            duration: const Duration(
                                                milliseconds: 100),
                                            curve: Curves.linear);
                                      } else {
                                        _scrollController.animateTo(
                                            screenHeight,
                                            duration: const Duration(
                                                milliseconds: 100),
                                            curve: Curves.linear);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                          ]))
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0, screenHeight / 45, screenWidth / 16, 0),
                    height: screenHeight / 18,
                    width: screenWidth / 3.5,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(screenHeight / 50)),
                    child: TextButton(
                        child: Text(
                          "Kaydet",
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w900,
                                  fontSize: screenHeight / 45)),
                          softWrap: true,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
            ],
          ))
    ])));
  }
}
