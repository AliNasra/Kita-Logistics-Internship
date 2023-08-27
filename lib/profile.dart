import 'dart:convert';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'drawer.dart';
import 'login_data.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File? _image;
  List<String> activityTypes = ["Ziyaret", "Yük Sorgulama", "Yeni Müşteri"];
  Map<dynamic, dynamic> userActivities = {};
  List<String> customerList = [];
  bool shouldRenderActivities = false;
  List<Map<dynamic, dynamic>> activitiesList = [];

  @override
  void initState() {
    super.initState();
    () async {
      await getActivities();
    }();
  }

  // This is the image picker
  ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    print("call on click add photo icon");
    ImagePicker _picker = ImagePicker();
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _image = File(pickedImage.path);
      var encoding = base64.encode(_image!.readAsBytesSync());
      await Provider.of<LoginData>(context, listen: false).setImage(encoding);
    }
    setState(() {});
  }

  Future<void> getActivities() async {
    DatabaseReference actionRef =
        FirebaseDatabase.instance.ref().child("Action");
    //print("Hello");
    //print(
    //    "User ID is ${Provider.of<LoginData>(context, listen: false).userID}");
    Query query = actionRef
        .orderByChild("employeeID")
        .equalTo(Provider.of<LoginData>(context, listen: false).userID);
    DataSnapshot event = await query.get();
    Map<dynamic, dynamic> employeeActivities =
        event.value as Map<dynamic, dynamic>;
    Set<String> companyNames = {};
    for (var key in employeeActivities.keys) {
      companyNames.add(employeeActivities[key]["companyID"]);
    }
    print("Customer List is ${companyNames}");
    customerList = [...companyNames.toList()];

    userActivities = {...employeeActivities};
    setState(() {});
  }

  List<Widget> renderActivities(double screenHeight, double screenWidth) {
    List<Widget> activityWidgetList = [];
    for (var activity in activityTypes) {
      activityWidgetList.add(
        GestureDetector(
          child: Container(
            margin:
                EdgeInsets.fromLTRB(0, screenHeight / 100, screenWidth / 25, 0),
            alignment: Alignment.center,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: _image == null
                      ? MemoryImage(
                          Provider.of<LoginData>(context, listen: false)
                              .profileImage)
                      : FileImage(
                          _image!,
                        ) as ImageProvider?,
                  radius: screenHeight / 16,
                ),
                Container(
                  height: screenHeight / 25,
                  child: Text(
                    "${activity}",
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            color: const Color.fromARGB(255, 193, 78, 91),
                            fontWeight: FontWeight.w900,
                            fontSize: screenHeight / 50)),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            activitiesList.clear();
            for (var key in userActivities.keys) {
              if (userActivities[key]["type"] == activity) {
                activitiesList.add(userActivities[key]);
              }
            }
            shouldRenderActivities = true;
            setState(() {});
          },
        ),
      );
    }
    return activityWidgetList;
  }

  List<Widget> renderCustomer(double screenHeight, double screenWidth) {
    List<Widget> activityWidgetList = [];
    for (var activity in customerList) {
      activityWidgetList.add(
        GestureDetector(
          child: Container(
            margin:
                EdgeInsets.fromLTRB(0, screenHeight / 100, screenWidth / 25, 0),
            alignment: Alignment.center,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: _image == null
                      ? MemoryImage(
                          Provider.of<LoginData>(context, listen: false)
                              .profileImage)
                      : FileImage(
                          _image!,
                        ) as ImageProvider?,
                  radius: screenHeight / 16,
                ),
                Container(
                  height: screenHeight / 25,
                  child: Text(
                    "${activity}",
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            color: const Color.fromARGB(255, 193, 78, 91),
                            fontWeight: FontWeight.w900,
                            fontSize: screenHeight / 50)),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return activityWidgetList;
  }

  List<Widget> renderActivityWidget(double screenHeight, double screenWidth) {
    List<Widget> activityWidgetList = [];
    for (var activity in activitiesList) {
      activityWidgetList.add(GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(
            context,
            '/activity',
            arguments: {'activity': activity},
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: screenHeight / 60),
          padding: EdgeInsets.only(left: screenWidth / 60),
          width: screenWidth / 1.1,
          height: screenHeight / 7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenHeight / 70),
              color: Colors.amber),
          child: Row(children: [
            Container(
              margin: EdgeInsets.only(right: screenWidth / 20),
              child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Image.asset("assets/logo.png"),
                  radius: screenHeight / 20),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: screenHeight / 30),
                  child: Text(
                    activity["companyID"],
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: screenHeight / 45)),
                    softWrap: true,
                  ),
                ),
                Text(
                  "Aktivite Türü: ${activity["type"]}",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight / 50)),
                  softWrap: true,
                ),
                Text(
                  "Aktivite Tarihi: ${DateTime.parse(activity["startDate"]).day}.${DateTime.parse(activity["startDate"]).month}.${DateTime.parse(activity["startDate"]).year}",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight / 50)),
                  softWrap: true,
                )
              ],
            )
          ]),
        ),
      ));
    }

    return activityWidgetList;
  }

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
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromARGB(255, 255, 211, 87),
                      Color.fromARGB(255, 255, 154, 78),
                    ],
                  )),
                  child: Container(
                    margin: EdgeInsets.only(top: screenHeight / 4),
                    height: screenHeight / 1.32,
                    decoration: new BoxDecoration(
                      color: Color.fromARGB(255, 243, 226, 178),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(
                              MediaQuery.of(context).size.width,
                              screenHeight / 7)),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(
                        0, screenHeight / 20, 0, screenHeight / 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, 0, 0, screenHeight / 100),
                              padding: EdgeInsets.fromLTRB(
                                  screenWidth / 40, 0, screenWidth / 40, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        _scaffoldKey.currentState!.openDrawer(),
                                    child: Container(
                                      child: Icon(
                                        Icons.menu_outlined,
                                        color: Colors.white,
                                        size: screenHeight / 10,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.notifications_active,
                                      color: Colors.white,
                                      size: screenHeight / 10,
                                    ),
                                  ),
                                ],
                              )),
                          Stack(
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, 0, screenHeight / 25),
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    backgroundImage: _image == null
                                        ? MemoryImage(Provider.of<LoginData>(
                                                context,
                                                listen: false)
                                            .profileImage)
                                        : FileImage(
                                            _image!,
                                          ) as ImageProvider?,
                                    radius: screenHeight / 9,
                                  )),
                              GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(screenWidth / 1.8,
                                      screenHeight / 6, 0, 0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amber,
                                  ),
                                  child: Icon(
                                    Icons.arrow_circle_up,
                                    size: screenHeight / 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: screenHeight / 25,
                            child: Text(
                              "${Provider.of<LoginData>(context).employeeName}",
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.w900,
                                      fontSize: screenHeight / 30)),
                              softWrap: true,
                            ),
                          ),
                          Container(
                            height: screenHeight / 20,
                            child: Text(
                              "${Provider.of<LoginData>(context).employeePosition}",
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenHeight / 35)),
                              softWrap: true,
                            ),
                          ),
                          Container(
                            child: shouldRenderActivities
                                ? Container(
                                    width: screenWidth,
                                    padding: EdgeInsets.fromLTRB(
                                        screenWidth / 20,
                                        screenHeight / 50,
                                        screenWidth / 20,
                                        screenHeight / 50),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            screenHeight / 80)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: screenHeight / 50),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Aktiviteler",
                                                style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize:
                                                            screenHeight / 25)),
                                                softWrap: true,
                                              ),
                                              GestureDetector(
                                                  child: Container(
                                                    child: Text(
                                                      "Geri dön",
                                                      style: GoogleFonts.quicksand(
                                                          textStyle: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  screenHeight /
                                                                      50)),
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    shouldRenderActivities =
                                                        false;
                                                    setState(() {});
                                                  }),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: screenHeight / 2.2,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: renderActivityWidget(
                                                  screenHeight, screenWidth),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Column(children: [
                                    Container(
                                        margin: EdgeInsets.fromLTRB(
                                            screenWidth / 20,
                                            screenHeight / 100,
                                            screenWidth / 20,
                                            0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Text(
                                                "Aktiviteler",
                                                style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenHeight / 50)),
                                                softWrap: true,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                activitiesList.clear();
                                                for (var key
                                                    in userActivities.keys) {
                                                  activitiesList
                                                      .add(userActivities[key]);
                                                }
                                                shouldRenderActivities = true;
                                                setState(() {});
                                              },
                                              child: Container(
                                                child: Text(
                                                  "Hepsini Gör",
                                                  style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              screenHeight /
                                                                  50)),
                                                  softWrap: true,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        height: screenHeight / 5.5,
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: renderActivities(
                                                  screenHeight, screenWidth),
                                            ))),
                                    Container(
                                        margin: EdgeInsets.fromLTRB(
                                            screenWidth / 20,
                                            screenHeight / 100,
                                            screenWidth / 20,
                                            0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Text(
                                                "Müşterilerim",
                                                style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenHeight / 50)),
                                                softWrap: true,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "Hepsini Gör",
                                                style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenHeight / 50)),
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        height: screenHeight / 5.5,
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: renderCustomer(
                                                  screenHeight, screenWidth),
                                            )))
                                  ]),
                          ),
                        ])),
              ],
            )));
  }
}
