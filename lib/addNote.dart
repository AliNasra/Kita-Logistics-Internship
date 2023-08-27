import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'drawer.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:intl/intl.dart';

import 'login_data.dart';

class addNote extends StatefulWidget {
  const addNote({super.key});

  @override
  State<addNote> createState() => addNoteState();
}

class addNoteState extends State<addNote> {
  final DatabaseReference activityRef =
      FirebaseDatabase.instance.ref().child("Activity");
  final DatabaseReference reminderRef =
      FirebaseDatabase.instance.ref().child("Reminder");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double screenHeight = 0;
  double screenWidth = 0;
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  final titleTextController = TextEditingController();
  final noteTextController = TextEditingController();
  final startDateTextController = TextEditingController();
  final endDateTextController = TextEditingController();
  String startHour = "01:00";
  String endHour = "01:00";
  int customizeNotification = 0;
  int notificationHour = 0;
  int notificationMinute = 0;
  String titleText = "";
  String noteText = "";
  List<String> items = List<String>.generate(24, (counter) {
    return "${NumberFormat("00").format(counter + 1)}:00";
  });
  List<String> repetitionItems = [
    "Her Gün",
    "Her İki Gün",
    "Her Hafta",
    "Her İki Hafta",
    "Her Ay"
  ];
  String selectedRepetitionFrequency = "Her Gün";
  String EmployeeName = "";

  void initState() {
    super.initState();
    EmployeeName = Provider.of<LoginData>(context, listen: false).employeeName;
  }

  Future<void> showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Başarı'),
          content: Text('Notunuz başarıyla eklendi'),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showFailureDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hata'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Tekrar dene'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> recordNote(BuildContext context) async {
    try {
      //int dayDiff = selectedEndDate.difference(selectedStartDate).inDays;
      //int weekDiff = (dayDiff / 7).floor();
      //int monthDiff = selected;
      DateTime StartDateStartHour = DateTime(
        selectedStartDate.year,
        selectedStartDate.month,
        selectedStartDate.day,
      ).add(Duration(hours: items.indexOf(startHour) + 1));
      DateTime StartDatefinalHour = DateTime(
        selectedStartDate.year,
        selectedStartDate.month,
        selectedStartDate.day,
      ).add(Duration(hours: items.indexOf(endHour) + 1));
      DateTime finalDateStartHour = DateTime(
        selectedEndDate.year,
        selectedEndDate.month,
        selectedEndDate.day,
      ).add(Duration(hours: items.indexOf(startHour) + 1));
      DateTime reminderTime = DateTime(
        selectedStartDate.year,
        selectedStartDate.month,
        selectedStartDate.day,
      ).subtract(
          Duration(hours: notificationHour, minutes: notificationMinute));
      //DateTime finalDatefinalHour = DateTime(
      //  selectedEndDate.year,
      //  selectedEndDate.month,
      //  selectedEndDate.day,
      //).add(Duration(hours: items.indexOf(endHour) + 1));

      if (items.indexOf(startHour) > items.indexOf(endHour)) {
        showFailureDialog("Başlangıç saati bitiş saati aşmamalı");
      } else if (!StartDateStartHour.isBefore(finalDateStartHour)) {
        showFailureDialog("Başlangıç tarihi bitiş tarihi aşmamalı");
      } else if (titleText == "" || noteText == "") {
        showFailureDialog("Lütfen Başlık veya Not boş bırakmayın");
      } else {
        Map<String, dynamic> activityEvents = {};
        Map<String, dynamic> reminderEvents = {};

        switch (selectedRepetitionFrequency) {
          case "Her Gün":
            DateTime currentStartTime = StartDateStartHour;
            DateTime currentEndTime = StartDatefinalHour;
            DateTime currentReminderTime = reminderTime;
            String noteID = "";
            String reminderID = "";
            while (currentStartTime.isBefore(finalDateStartHour)) {
              noteID = Random().nextInt(10000).toString();
              reminderID = Random().nextInt(10000).toString();
              activityEvents[noteID] = {
                "startDate": currentStartTime.toString(),
                "endDate": currentEndTime.toString(),
                "title": titleText,
                "note": noteText,
                "noteTaker": EmployeeName,
              };
              reminderEvents[reminderID] = {
                "noteID": noteID,
                "reminderTime": currentReminderTime.toString(),
                "noteTaker": EmployeeName
              };

              currentStartTime = currentStartTime.add(Duration(days: 1));
              currentEndTime = currentEndTime.add(Duration(days: 1));
              currentReminderTime = currentReminderTime.add(Duration(days: 1));
            }
            break;
          case "Her İki Gün":
            DateTime currentStartTime = StartDateStartHour;
            DateTime currentEndTime = StartDatefinalHour;
            DateTime currentReminderTime = reminderTime;
            String noteID = "";
            String reminderID = "";
            while (currentStartTime.isBefore(finalDateStartHour)) {
              noteID = Random().nextInt(10000).toString();
              reminderID = Random().nextInt(10000).toString();
              activityEvents[noteID] = {
                "startDate": currentStartTime.toString(),
                "endDate": currentEndTime.toString(),
                "title": titleText,
                "note": noteText,
                "noteTaker": EmployeeName,
              };
              reminderEvents[reminderID] = {
                "noteID": noteID,
                "reminderTime": currentReminderTime.toString(),
                "noteTaker": EmployeeName
              };

              currentStartTime = currentStartTime.add(Duration(days: 2));
              currentEndTime = currentEndTime.add(Duration(days: 2));
              currentReminderTime = currentReminderTime.add(Duration(days: 2));
            }
            break;
          case "Her Hafta":
            DateTime currentStartTime = StartDateStartHour;
            DateTime currentEndTime = StartDatefinalHour;
            DateTime currentReminderTime = reminderTime;
            String noteID = "";
            String reminderID = "";
            while (currentStartTime.isBefore(finalDateStartHour)) {
              noteID = Random().nextInt(10000).toString();
              reminderID = Random().nextInt(10000).toString();
              activityEvents[noteID] = {
                "startDate": currentStartTime.toString(),
                "endDate": currentEndTime.toString(),
                "title": titleText,
                "note": noteText,
                "noteTaker": EmployeeName,
              };
              reminderEvents[reminderID] = {
                "noteID": noteID,
                "reminderTime": currentReminderTime.toString(),
                "noteTaker": EmployeeName
              };

              currentStartTime = currentStartTime.add(Duration(days: 7));
              currentEndTime = currentEndTime.add(Duration(days: 7));
              currentReminderTime = currentReminderTime.add(Duration(days: 7));
            }
            break;
          case "Her İki Hafta":
            DateTime currentStartTime = StartDateStartHour;
            DateTime currentEndTime = StartDatefinalHour;
            DateTime currentReminderTime = reminderTime;
            String noteID = "";
            String reminderID = "";
            while (currentStartTime.isBefore(finalDateStartHour)) {
              noteID = Random().nextInt(10000).toString();
              reminderID = Random().nextInt(10000).toString();
              activityEvents[noteID] = {
                "startDate": currentStartTime.toString(),
                "endDate": currentEndTime.toString(),
                "title": titleText,
                "note": noteText,
                "noteTaker": EmployeeName,
              };
              reminderEvents[reminderID] = {
                "noteID": noteID,
                "reminderTime": currentReminderTime.toString(),
                "noteTaker": EmployeeName
              };

              currentStartTime = currentStartTime.add(Duration(days: 14));
              currentEndTime = currentEndTime.add(Duration(days: 14));
              currentReminderTime = currentReminderTime.add(Duration(days: 14));
            }
            break;
          case "Her Ay":
            DateTime currentStartTime = StartDateStartHour;
            DateTime currentEndTime = StartDatefinalHour;
            DateTime currentReminderTime = reminderTime;
            String noteID = "";
            String reminderID = "";
            while (currentStartTime.isBefore(finalDateStartHour) == true) {
              noteID = Random().nextInt(10000).toString();
              reminderID = Random().nextInt(10000).toString();
              activityEvents[noteID] = {
                "startDate": currentStartTime.toString(),
                "endDate": currentEndTime.toString(),
                "title": titleText,
                "note": noteText,
                "noteTaker": EmployeeName,
              };
              reminderEvents[reminderID] = {
                "noteID": noteID,
                "reminderTime": currentReminderTime.toString(),
                "noteTaker": EmployeeName
              };

              currentStartTime = DateTime(
                  currentStartTime.year,
                  currentStartTime.month + 1,
                  currentStartTime.day,
                  currentStartTime.hour);
              currentEndTime = DateTime(
                  currentEndTime.year,
                  currentEndTime.month + 1,
                  currentEndTime.day,
                  currentEndTime.hour);
              currentReminderTime = DateTime(
                  currentReminderTime.year,
                  currentReminderTime.month + 1,
                  currentReminderTime.day,
                  currentReminderTime.hour,
                  currentReminderTime.minute);
            }
            break;
        }
        //print("Activities are: ${activityEvents}");
        activityRef.update(activityEvents).then((_) {
          reminderRef.update(reminderEvents).then((_) {
            showSuccessDialog();
          }).catchError((error) {
            showFailureDialog(error);
          });
        }).catchError((error) {
          showFailureDialog(error);
        });
      }
    } catch (error) {
      showFailureDialog(error.toString());
    }
  }

  Widget getNotification(double screenHeight, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            padding:
                EdgeInsets.fromLTRB(0, screenHeight / 50, screenWidth / 25, 0),
            child: (customizeNotification == 1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                            height: screenHeight / 30,
                            width: screenWidth / 3,
                            padding:
                                EdgeInsets.fromLTRB(screenWidth / 30, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Bildiri Vakti",
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w900,
                                          fontSize: screenHeight / 40)),
                                  softWrap: true,
                                ),
                              ],
                            )),
                        Row(children: [
                          Column(children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Saat",
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.w900,
                                          fontSize: screenHeight / 40)),
                                  softWrap: true,
                                )),
                            SizedBox(
                              width: screenWidth / 6,
                              height: screenHeight / 12,
                              child: WheelChooser(
                                  selectTextStyle: TextStyle(
                                      color: Colors.white,
                                      backgroundColor:
                                          Color.fromARGB(255, 1, 34, 61),
                                      fontWeight: FontWeight.w800),
                                  onValueChanged: (newHour) {
                                    notificationHour = newHour;
                                    setState(() {});
                                  },
                                  startPosition: 0,
                                  datas: List<int>.generate(
                                      24, (int index) => index,
                                      growable: false)),
                            )
                          ]),
                          Column(children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Dakika",
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.w900,
                                          fontSize: screenHeight / 40)),
                                  softWrap: true,
                                )),
                            SizedBox(
                              width: screenWidth / 6,
                              height: screenHeight / 12,
                              child: WheelChooser(
                                  selectTextStyle: TextStyle(
                                      color: Colors.white,
                                      backgroundColor:
                                          Color.fromARGB(255, 1, 34, 61),
                                      fontWeight: FontWeight.w800),
                                  onValueChanged: (newMinute) {
                                    notificationMinute = newMinute;
                                    setState(() {});
                                  },
                                  startPosition: 0,
                                  datas: List<int>.generate(
                                      60, (int index) => index,
                                      growable: false)),
                            )
                          ])
                        ])
                      ])
                : Container())),
      ],
    );
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    ScrollController _scrollController = ScrollController();
    //print("selectedStartDate is ${selectedStartDate}");
    //print("selectedEndDate is ${selectedEndDate}");
    return Scaffold(
        key: _scaffoldKey,
        drawer: MainDrawer(screenHeight, screenWidth, context),
        backgroundColor: Color.fromARGB(255, 243, 213, 124),
        body: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 100),
                      padding: EdgeInsets.fromLTRB(
                          screenWidth / 100,
                          screenHeight / 50,
                          screenWidth / 100,
                          screenHeight / 50),
                      height: screenHeight / 7,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 213, 124)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: GestureDetector(
                                onTap: () =>
                                    _scaffoldKey.currentState!.openDrawer(),
                                child: Icon(
                                  Icons.menu,
                                  color: Color.fromARGB(255, 255, 193, 7),
                                  size: screenHeight / 10,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Image.asset('assets/logo.png'),
                                  radius: (screenHeight / 20)),
                            ),
                          ])),
                  Container(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth / 30,
                          screenHeight / 200,
                          screenWidth / 100,
                          screenHeight / 200),
                      child: Text(
                        "Not Ekle",
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w900,
                                fontSize: screenHeight / 25)),
                        softWrap: true,
                      )),
                  Container(
                      height: (customizeNotification == 0
                          ? screenHeight / 1.1
                          : screenHeight / 1.05),
                      width: screenWidth,
                      padding: EdgeInsets.fromLTRB(screenWidth / 25,
                          screenHeight / 25, screenWidth / 25, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(screenHeight / 30)),
                          border: Border(
                              top: BorderSide(
                                  color: Colors.white,
                                  width: screenHeight / 500),
                              bottom: BorderSide(
                                  color: Colors.white,
                                  width: screenHeight / 500),
                              left: BorderSide(
                                  color: Colors.white,
                                  width: screenHeight / 500),
                              right: BorderSide(
                                  color: Colors.white,
                                  width: screenHeight / 500))),
                      child: Column(children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, 0, screenHeight / 100),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Başlangıç Tarihi",
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w900,
                                            fontSize: screenHeight / 28)),
                                    softWrap: true,
                                  )),
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, 0, screenHeight / 100),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: screenHeight / 20,
                                        width: screenWidth / 2.5,
                                        padding: EdgeInsets.fromLTRB(
                                            screenWidth / 50,
                                            screenHeight / 100,
                                            screenWidth / 100,
                                            screenHeight / 200),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    screenHeight / 80),
                                                bottomLeft: Radius.circular(
                                                    screenHeight / 80))),
                                        child: TextField(
                                            style: TextStyle(
                                                fontSize: screenHeight / 40,
                                                fontWeight: FontWeight.w900),
                                            readOnly: true,
                                            controller: startDateTextController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none)),
                                      ),
                                      Container(
                                        height: screenHeight / 20,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 250, 245, 237),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(
                                                    screenHeight / 80),
                                                bottomRight: Radius.circular(
                                                    screenHeight / 80))),
                                        child: IconButton(
                                          color: Colors.amber,
                                          iconSize: screenHeight / 30,
                                          icon: Icon(Icons.calendar_today),
                                          tooltip: 'Tap to open date picker',
                                          onPressed: () {
                                            showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(
                                                    DateTime.now().year + 2),
                                                builder: (context, picker) {
                                                  return Theme(
                                                    //TODO: change colors
                                                    data: ThemeData.dark(),
                                                    child: picker!,
                                                  );
                                                }).then((selectedDate) {
                                              //TODO: handle selected date
                                              if (selectedDate != null) {
                                                selectedStartDate =
                                                    selectedDate;
                                                //print(selectedStartDate);
                                                startDateTextController.text =
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(selectedDate);
                                                setState(() {});
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            screenWidth / 100,
                                            screenHeight / 200,
                                            screenWidth / 100,
                                            screenHeight / 200),
                                        width: screenWidth / 4,
                                        height: screenHeight / 20,
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.circular(
                                                screenHeight / 80)),
                                        margin: EdgeInsets.fromLTRB(
                                            screenWidth / 30, 0, 0, 0),
                                        child: DropdownButton(
                                          dropdownColor: Colors.amber,
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          iconSize: screenHeight / 25,
                                          iconEnabledColor: Colors.white,
                                          value: items.isEmpty ? "" : startHour,
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          items: items.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                items,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            if (newValue != null) {
                                              startHour = newValue;
                                              setState(() {});
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Bitiş Tarihi",
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w900,
                                            fontSize: screenHeight / 28)),
                                    softWrap: true,
                                  )),
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, 0, screenHeight / 100),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: screenHeight / 20,
                                        width: screenWidth / 2.5,
                                        padding: EdgeInsets.fromLTRB(
                                            screenWidth / 50,
                                            screenHeight / 100,
                                            screenWidth / 100,
                                            screenHeight / 200),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    screenHeight / 80),
                                                bottomLeft: Radius.circular(
                                                    screenHeight / 80))),
                                        child: TextField(
                                            style: TextStyle(
                                                fontSize: screenHeight / 40,
                                                fontWeight: FontWeight.w900),
                                            readOnly: true,
                                            controller: endDateTextController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none)),
                                      ),
                                      Container(
                                        height: screenHeight / 20,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 250, 245, 237),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(
                                                    screenHeight / 80),
                                                bottomRight: Radius.circular(
                                                    screenHeight / 80))),
                                        child: IconButton(
                                          color: Colors.amber,
                                          iconSize: screenHeight / 30,
                                          icon: Icon(Icons.calendar_today),
                                          tooltip: 'Tap to open date picker',
                                          onPressed: () {
                                            showDatePicker(
                                                context: context,
                                                initialDate: selectedStartDate,
                                                firstDate: selectedStartDate,
                                                lastDate: DateTime(
                                                    selectedStartDate.year + 2),
                                                builder: (context, picker) {
                                                  return Theme(
                                                    //TODO: change colors
                                                    data: ThemeData.dark(),
                                                    child: picker!,
                                                  );
                                                }).then((selectedDate) {
                                              //TODO: handle selected date
                                              if (selectedDate != null) {
                                                selectedEndDate = selectedDate;
                                                endDateTextController.text =
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(selectedDate);
                                                setState(() {});
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            screenWidth / 100,
                                            screenHeight / 200,
                                            screenWidth / 100,
                                            screenHeight / 200),
                                        width: screenWidth / 4,
                                        height: screenHeight / 20,
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.circular(
                                                screenHeight / 80)),
                                        margin: EdgeInsets.fromLTRB(
                                            screenWidth / 30, 0, 0, 0),
                                        child: DropdownButton(
                                          dropdownColor: Colors.amber,
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          iconSize: screenHeight / 25,
                                          iconEnabledColor: Colors.white,
                                          value: items.isEmpty ? "" : endHour,
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          items: items.map((String items) {
                                            return DropdownMenuItem(
                                                value:
                                                    items.isEmpty ? "" : items,
                                                child: Text(
                                                  items,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ));
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            if (newValue != null) {
                                              endHour = newValue;
                                              setState(() {});
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                child: Row(
                                  children: [],
                                ),
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Başlık",
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w900,
                                            fontSize: screenHeight / 28)),
                                    softWrap: true,
                                  )),
                              Container(
                                  width: screenWidth / 1.1,
                                  height: screenHeight / 20,
                                  padding: EdgeInsets.fromLTRB(
                                      screenWidth / 50,
                                      screenHeight / 200,
                                      screenWidth / 50,
                                      screenHeight / 200),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          screenHeight / 80),
                                      color:
                                          Color.fromARGB(253, 249, 233, 255)),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    maxLines: 1,
                                    controller: titleTextController,
                                  )),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Not",
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w900,
                                            fontSize: screenHeight / 28)),
                                    softWrap: true,
                                  )),
                              Container(
                                  padding: EdgeInsets.fromLTRB(
                                      screenWidth / 50,
                                      screenHeight / 200,
                                      screenWidth / 50,
                                      screenHeight / 500),
                                  alignment: Alignment.centerLeft,
                                  width: screenWidth / 1.1,
                                  height: screenHeight / 13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          screenHeight / 80),
                                      color:
                                          Color.fromARGB(253, 249, 233, 255)),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    expands: true,
                                    controller: noteTextController,
                                  )),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Column(children: [
                                          Text(
                                            "Öncelik",
                                            style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontWeight: FontWeight.w900,
                                                    fontSize:
                                                        screenHeight / 28)),
                                            softWrap: true,
                                          ),
                                          Row(children: [
                                            GestureDetector(
                                              child: Icon(Icons.circle,
                                                  color: Colors.black),
                                              onTap: () {},
                                            ),
                                            GestureDetector(
                                              child: Icon(Icons.circle,
                                                  color: Colors.yellow),
                                              onTap: () {},
                                            ),
                                            GestureDetector(
                                              child: Icon(Icons.circle,
                                                  color: Colors.red),
                                              onTap: () {},
                                            )
                                          ])
                                        ])),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                              Text(
                                                "Hatırlat",
                                                style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize:
                                                            screenHeight / 28)),
                                                softWrap: true,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    height: screenHeight / 25,
                                                    child: ToggleSwitch(
                                                      minWidth: screenWidth / 5,
                                                      cornerRadius:
                                                          screenHeight / 100,
                                                      activeBgColors: [
                                                        [Colors.red],
                                                        [Colors.green]
                                                      ],
                                                      activeFgColor:
                                                          Colors.white,
                                                      inactiveBgColor:
                                                          Colors.grey,
                                                      inactiveFgColor:
                                                          Colors.white,
                                                      initialLabelIndex:
                                                          customizeNotification,
                                                      totalSwitches: 2,
                                                      labels: ['Hayır', 'Evet'],
                                                      radiusStyle: true,
                                                      onToggle: (index) {
                                                        customizeNotification =
                                                            index!;
                                                        setState(() {});
                                                        if (index == 0) {
                                                          _scrollController.animateTo(
                                                              0,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          100),
                                                              curve: Curves
                                                                  .linear);
                                                        } else {
                                                          _scrollController.animateTo(
                                                              screenHeight,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          100),
                                                              curve: Curves
                                                                  .linear);
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]))
                                      ])),
                            ]),
                        getNotification(screenHeight, screenWidth),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              screenWidth / 100,
                              screenHeight / 200,
                              screenWidth / 100,
                              screenHeight / 200),
                          width: screenWidth / 3,
                          height: screenHeight / 7,
                          margin: EdgeInsets.fromLTRB(screenWidth / 2, 0, 0, 0),
                          child: Column(
                            children: [
                              Text(
                                "Yineleme",
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w900,
                                        fontSize: screenHeight / 28)),
                                softWrap: true,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(
                                        screenHeight / 80)),
                                child: DropdownButton(
                                  dropdownColor: Colors.amber,
                                  padding: EdgeInsets.fromLTRB(
                                      screenWidth / 30, 0, screenWidth / 50, 0),
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  iconSize: screenHeight / 25,
                                  iconEnabledColor: Colors.white,
                                  value: repetitionItems.isEmpty
                                      ? ""
                                      : selectedRepetitionFrequency,
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  items: repetitionItems.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      selectedRepetitionFrequency = newValue;
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, screenHeight / 200, screenWidth / 16, 0),
                              height: screenHeight / 18,
                              width: screenWidth / 3.5,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius:
                                      BorderRadius.circular(screenHeight / 50)),
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
                                    titleText = titleTextController.text;
                                    noteText = noteTextController.text;
                                    setState(() {});
                                    recordNote(context);
                                    titleTextController.text = "";
                                    noteTextController.text = "";
                                    startDateTextController.text = "";
                                    endDateTextController.text = "";
                                    startHour = "01:00";
                                    endHour = "01:00";
                                    customizeNotification = 0;
                                    notificationHour = 0;
                                    notificationMinute = 0;
                                    setState(() {});
                                  }),
                            ),
                          ],
                        ),
                      ]))
                ]))));
  }
}
