import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'drawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login_data.dart';

class calendar extends StatefulWidget {
  const calendar({super.key});

  @override
  State<calendar> createState() => calendarState();
}

class calendarState extends State<calendar> {
  final DatabaseReference activityRef =
      FirebaseDatabase.instance.ref().child("Activity");
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  double screenHeight = 0;
  double screenWidth = 0;
  NumberFormat formatter = new NumberFormat("00");
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
  List<dynamic> todayEvent = [];
  Map<dynamic, dynamic> monthEvent = {};
  List<Widget> todayEventwidgets = [];
  String employeeName = "";
  @override
  void initState() {
    super.initState();
    employeeName = Provider.of<LoginData>(context, listen: false).employeeName;
    initializeDateFormatting();
    (() async {
      await initializeMonthEvent(DateTime.now());
    })();
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    List<dynamic> dailyEvents = [];
    for (final key in monthEvent.keys) {
      if (DateTime.parse(monthEvent[key]['startDate']).day == day.day &&
          DateTime.parse(monthEvent[key]['startDate']).month == day.month &&
          DateTime.parse(monthEvent[key]['startDate']).year == day.year) {
        dailyEvents.add(monthEvent[key]);
      }
    }
    return dailyEvents;
  }

  Future<void> initializeMonthEvent(DateTime date) async {
    monthEvent.clear();
    Query query = activityRef.orderByChild("noteTaker").equalTo(employeeName);
    DataSnapshot event = await query.get();
    //Map<dynamic, dynamic> activities = event.value as Map<dynamic, dynamic>;
    //print("object is here");
    Map<dynamic, dynamic> activities = event.value as Map<dynamic, dynamic>;
    for (final key in activities.keys) {
      if (DateTime.parse(activities[key]['startDate']).month == date.month) {
        monthEvent[key] = activities[key];
      }
    }
    print(monthEvent);
    setState(() {});
  }

  void selectTodayEvent(DateTime day) {
    todayEvent.clear();
    for (final key in monthEvent.keys) {
      if (DateTime.parse(monthEvent[key]['startDate']).day == day.day &&
          DateTime.parse(monthEvent[key]['startDate']).month == day.month &&
          DateTime.parse(monthEvent[key]['startDate']).year == day.year) {
        todayEvent.add(monthEvent[key]);
      }
      print(todayEvent);
      todayEvent.sort((a, b) => DateTime.parse(a["startDate"])
          .hour
          .compareTo(DateTime.parse(b["startDate"]).hour));
    }
    setState(() {});
  }

  List<Widget> renderTimeline(
      DateTime date, double screenHeight, double screenWidth) {
    todayEventwidgets.clear();
    for (int counter = 0; counter < todayEvent.length; counter++) {
      todayEventwidgets.add(Container(
        alignment: Alignment.center,
        child: Container(
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(Icons.radio_button_unchecked_outlined,
                size: screenHeight / 20,
                color: Color.fromARGB(255, 251, 192, 0)),
            Container(
              padding: EdgeInsets.fromLTRB(0, screenHeight / 100, 0, 0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 251, 155, 0),
                borderRadius: BorderRadius.circular(screenHeight / 50),
                border: Border.all(
                    color: const Color.fromARGB(255, 219, 243, 33),
                    style: BorderStyle.solid),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(
                  0, screenHeight / 100, 0, screenHeight / 100),
              width: screenWidth / 1.8,
              height: screenHeight / 10,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Başlangıç saati: ${DateTime.parse(todayEvent[counter]["startDate"]).hour}:00\nBitiş saati: ${DateTime.parse(todayEvent[counter]["endDate"]).hour}:00",
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: screenHeight / 60)),
                      softWrap: true,
                    ),
                  ),
                  Container(
                    child: Text(
                      todayEvent[counter]["title"],
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: screenHeight / 40)),
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ));
    }
    setState(() {});
    return todayEventwidgets;
  }

  @override
  Widget build(BuildContext context) {
    double tempHeight = MediaQuery.of(context).size.height;
    double tempWidth = MediaQuery.of(context).size.width;
    double screenHeight =
        (MediaQuery.of(context).orientation == Orientation.portrait
            ? tempHeight
            : tempWidth);
    double screenWidth = tempWidth;
    return Scaffold(
      key: _scaffoldKey,
      drawer: MainDrawer(screenHeight, screenWidth, context),
      backgroundColor: Color.fromARGB(255, 243, 213, 124),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.fromLTRB(screenWidth / 100, screenHeight / 50,
                screenWidth / 100, screenHeight / 50),
            height: screenHeight / 7,
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 243, 213, 124)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: () => _scaffoldKey.currentState!.openDrawer(),
                    child: Icon(
                      Icons.menu,
                      color: Color.fromARGB(255, 255, 193, 7),
                      size: screenHeight / 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.fromLTRB(
                      screenWidth / 100, 0, screenWidth / 100, 0),
                  child: Text(
                    textAlign: TextAlign.center,
                    "${monthsInYear[focusedDate.month]} ${focusedDate.year}",
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight / 20)),
                    softWrap: true,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Image.asset('assets/logo.png'),
                      radius: (screenHeight / 40)),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 30),
            padding:
                EdgeInsets.fromLTRB(screenWidth / 10, 0, screenWidth / 10, 0),
            color: Color.fromARGB(255, 243, 213, 124),
            child: TableCalendar(
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) => events.isNotEmpty
                    ? Container(
                        width: screenWidth / 50,
                        height: screenHeight / 50,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                        child: Text(
                          '${events.length}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      )
                    : null,
              ),
              locale: "tr_TR",
              firstDay: DateTime.utc(today.year - 10, today.month, today.day),
              focusedDay: focusedDate,
              lastDay: DateTime.utc(today.year + 10, today.month, today.day),
              headerVisible: false,
              availableGestures: AvailableGestures.all,
              calendarStyle: CalendarStyle(
                  outsideTextStyle: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black),
                  weekendTextStyle: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black),
                  selectedDecoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  selectedTextStyle: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black),
                  defaultTextStyle: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black)),
              daysOfWeekHeight: screenHeight / 20,
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                      fontSize: screenHeight / 40, fontWeight: FontWeight.w800),
                  weekendStyle: TextStyle(
                      fontSize: screenHeight / 40, fontWeight: FontWeight.w800),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: screenHeight / 300,
                              style: BorderStyle.solid)))),
              rowHeight: screenHeight / 15,
              eventLoader: (day) {
                return _getEventsForDay(day);
              },
              selectedDayPredicate: (day) => isSameDay(day, selectedDate),
              onDaySelected: (selectedDay, focusedDay) {
                selectedDate = selectedDay;
                setState(() {});
                selectTodayEvent(selectedDate);
              },
              onPageChanged: (focusedDay) async {
                focusedDate = focusedDay;
                setState(() {});
                await initializeMonthEvent(focusedDay);
              },
            ),
          ),
          Container(
              width: screenWidth,
              height: screenHeight / 2.25,
              padding: EdgeInsets.fromLTRB(
                  screenWidth / 50, screenHeight / 40, 0, 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: Colors.white, width: screenWidth / 100),
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(screenHeight / 50),
                    bottom: Radius.circular(screenHeight / 50)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenWidth / 1.3,
                    child: Column(
                      children: [
                        Text(
                          selectedDate.day == DateTime.now().day &&
                                  selectedDate.month == DateTime.now().month &&
                                  selectedDate.year == DateTime.now().year
                              ? "Bugün Etkinlikleri\n"
                              : "${formatter.format(selectedDate.day)}-${formatter.format(selectedDate.month)}-${selectedDate.year} Günün Etkinlikleri:",
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: screenHeight / 25)),
                          softWrap: true,
                        ),
                        Container(
                          height: screenHeight / 4,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                                children: renderTimeline(
                                    selectedDate, screenHeight, screenWidth)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(screenHeight / 50),
                                  color: Colors.amber),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: screenHeight / 13,
                              ),
                            ),
                            onTap: () async {
                              await Navigator.pushNamed(context, '/addNote');
                            }),
                      ],
                    ),
                  ),
                ],
              )),
        ])),
      ),
    );
  }
}

/**
 * 
 */