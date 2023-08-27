import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_application/map_data.dart';
import 'package:provider/provider.dart';

import 'login_data.dart';

class DatabaseData extends ChangeNotifier {
  final listFirmTextController = TextEditingController();
  final queryTextController =
      TextEditingController(); //The text box containing filtering text
  //bool showFilter = false;
  Map<dynamic, dynamic> companyList =
      {}; //Storing the matching company objects retrieved from the database
  final DatabaseReference companyRef = FirebaseDatabase.instance
      .ref()
      .child("Company"); //Reference to the company table in the database
  String selectedSector = "Hepsi"; //Initial sector setting
  String filteringText = ""; //Query text in the search page
  String recommendationText = ""; // Query text in the recommendation page
  List<Widget> companyListWidget =
      []; // Visual rendition of the retrieved companies
  List<Widget> sectorListWidget =
      []; // Visual rendition of the retrieved sectors
  Map<String, bool> sectorStatus = {
    "Hepsi": true,
    "Tekstil": false,
    "Sanayi": false
  }; //The initial three sectors displayed on the screen. Hepsi is initially selected
  Map<String, bool> sectorSelected = {
    "Hepsi": false,
    "Tekstil": false,
    "Sanayi": false,
    "Hayvancılık": false,
    "Madencilik": false,
    "Hizmet": false,
    "Turizm": false
  }; // Sectors that can be added later on. False means that neither any one of them is selected
  List<double> _center =
      []; // The reference coordinates"Either the user's location of the selected company"
  //bool isSectorSelected = false;
  String EmployeeName = ""; //Getting the employee name from the provider
  List<String> companyNameList =
      []; // Getting the string list of the retrieved companies

  void setEmployeeName(BuildContext context) {
    EmployeeName = Provider.of<LoginData>(context, listen: false).employeeName;
  }

  Map<String, bool> getsectorStatus() {
    return sectorStatus;
  }

  //Set the origin as the user's current location
  void setCenter(BuildContext context) {
    _center = [];
    _center = [
      Provider.of<MapData>(context, listen: false).locationData!.latitude!,
      Provider.of<MapData>(context, listen: false).locationData!.longitude!
    ];
  }

  //Set the origin as the selected company in the recommendation page
  Future<void> updateCenter(BuildContext context, String name) async {
    _center = [];
    var keyVal;
    companyList.clear();
    Query query = companyRef.orderByChild("salesperson").equalTo(EmployeeName);
    DataSnapshot event = await query.get();
    Map<dynamic, dynamic> tempCompanyList =
        event.value as Map<dynamic, dynamic>;
    companyList = {...tempCompanyList};
    for (var key in companyList.keys) {
      if (companyList[key]["name"] == name) {
        _center.add(companyList[key]["latitude"]);
        _center.add(companyList[key]["longitude"]);
        keyVal = key;
        break;
      }
    }
    companyList.remove(keyVal);
    //print("CompanyList is ${companyList}");
    await getDistances();
  }

  //Update the values of the sectors displayed currently on the screen
  Future<void> setsectorStatus(BuildContext context, String key, bool val,
      double screenHeight, double screenWidth) async {
    sectorStatus[key] = val;
    await getCompanies(context, screenHeight, screenWidth);
  }

  //Update the query text in the search page
  Future<void> setFilteringText(BuildContext context, String val,
      double screenHeight, double screenWidth) async {
    filteringText = val;
    await getCompanies(context, screenHeight, screenWidth);
  }

  void setQuery(String val, double screenHeight, double screenWidth) async {
    queryTextController.text = val;
    //notifyListeners();
    //await getCompanies(screenHeight, screenWidth);
  }

  Map<String, bool> getSectorSelected() {
    return sectorSelected;
  }

  //Update the value of the sectors that can be added to the screen. We are appending them to the existing list
  void setSectorSelect(String key, bool val) {
    sectorSelected[key] = val;
    notifyListeners();
  }

  String getQueryText() {
    return queryTextController.text;
  }

  TextEditingController getController() {
    return queryTextController;
  }

  //Render the sector list in the search page
  List<Widget> renderSectors(
      BuildContext context, double screenHeight, double screenWidth) {
    sectorListWidget.clear();
    for (var key in sectorStatus.keys) {
      sectorListWidget.add(
        GestureDetector(
            onTap: () async {
              selectedSector = key;
              for (var tempkey in sectorStatus.keys) {
                sectorStatus[tempkey] = false;
              }
              sectorStatus[key] = true;
              await getCompanies(context, screenHeight, screenWidth);
              notifyListeners();
            },
            child: Container(
                width: screenWidth / 5,
                height: screenHeight / 25,
                margin: EdgeInsets.fromLTRB(0, 0, screenWidth / 50, 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromARGB(255, 254, 191, 52),
                        Color.fromARGB(255, 255, 157, 79)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(screenHeight / 80)),
                child: Expanded(
                  child: Text(
                    key,
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            color: sectorStatus[key]!
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: screenHeight / 50)),
                    softWrap: false,
                  ),
                ))),
      );
    }
    return sectorListWidget;
  }

  //Render the widgets representing the companies in search and recommend page
  void renderCompanies(
      BuildContext context, double screenHeight, double screenWidth) {
    companyListWidget.clear();
    for (var company in companyList.keys) {
      companyListWidget.add(GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(
            context,
            '/address',
            arguments: {'companyData': companyList[company]},
          );
        },
        child: Container(
          margin:
              EdgeInsets.fromLTRB(0, screenHeight / 100, 0, screenHeight / 100),
          width: screenWidth / 1.2,
          height: screenHeight / 8,
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(screenHeight / 80)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(screenWidth / 100,
                    screenHeight / 200, 0, screenHeight / 200),
                alignment: Alignment.center,
                child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Image.asset('assets/logo.png'),
                    radius: (screenHeight / 20)),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(screenWidth / 30,
                    screenHeight / 200, screenWidth / 50, screenHeight / 200),
                child: Column(
                  children: [
                    Container(
                      width: screenWidth / 2,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 200),
                      child: Text(
                        companyList[company]["name"],
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: screenHeight / 50)),
                        softWrap: false,
                      ),
                    ),
                    Container(
                      width: screenWidth / 2,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 70),
                      child: Text(
                        companyList[company]["fullName"],
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: screenHeight / 50)),
                        softWrap: false,
                      ),
                    ),
                    Container(
                      width: screenWidth / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color.fromARGB(255, 254, 191, 52),
                                    Color.fromARGB(255, 255, 157, 79)
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.circular(screenHeight / 80)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.map_sharp),
                                Text(
                                  companyList[company]["distance"],
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: screenHeight / 50)),
                                  softWrap: false,
                                ),
                              ],
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color.fromARGB(255, 254, 191, 52),
                                      Color.fromARGB(255, 255, 157, 79)
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(screenHeight / 80)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.access_time_filled_outlined),
                                  Text(
                                    companyList[company]["duration"],
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: screenHeight / 50)),
                                    softWrap: false,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }
    //return companyListWidget;
    notifyListeners();
  }

  //Retrieve the companies accoding to the input text supplied from the search page
  Future<void> getCompanies(
      BuildContext context, double screenHeight, double screenWidth) async {
    companyList.clear();
    Query query = companyRef.orderByChild("salesperson").equalTo(EmployeeName);
    DataSnapshot event = await query.get();
    Map<dynamic, dynamic> tempCompanyList =
        event.value as Map<dynamic, dynamic>;
    if (selectedSector != "Hepsi") {
      for (final key in tempCompanyList.keys) {
        if (tempCompanyList[key]['sector'] == selectedSector) {
          companyList[key] = tempCompanyList[key];
        }
      }
    } else {
      companyList = {...tempCompanyList};
    }
    if (filteringText.trim() != "") {
      companyList
          .removeWhere((key, value) => !value["name"].contains(filteringText));
    }
    await getDistances();
    renderCompanies(context, screenHeight, screenWidth);
  }

  //Add a sector to the list of sector displayed in the search page
  void addSector(double screenHeight, double screenWidth, context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          for (var sector in getSectorSelected().keys) {
            setSectorSelect(sector, false);
          }
          String sectorToBeAdded = "";
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.grey,
              title: Text(
                'Sector List',
                style: TextStyle(color: Colors.white),
              ),
              content: Container(
                height: screenHeight / 2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List<Widget>.generate(
                          getSectorSelected().keys.length,
                          (int index) => GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, 0, screenHeight / 100),
                                  decoration: BoxDecoration(
                                      color: getSectorSelected()[
                                                  getSectorSelected()
                                                      .keys
                                                      .elementAt(index)] ==
                                              true
                                          ? Color.fromARGB(255, 234, 75, 7)
                                          : Colors.amber,
                                      borderRadius: BorderRadius.circular(
                                          screenHeight / 80)),
                                  height: screenHeight / 10,
                                  width: screenWidth / 2,
                                  child: Text(
                                    getSectorSelected().keys.elementAt(index),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: screenHeight / 50)),
                                    softWrap: false,
                                  ),
                                ),
                                onTap: () {
                                  List<String> SectorSelectedKeys =
                                      getSectorSelected().keys.toList();
                                  for (var sector in SectorSelectedKeys) {
                                    setSectorSelect(sector, false);
                                  }
                                  setSectorSelect(
                                      SectorSelectedKeys.elementAt(index),
                                      true);
                                  sectorToBeAdded =
                                      getSectorSelected().keys.elementAt(index);
                                  setState(() {});
                                },
                              ))),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Sektörü ekle'),
                  onPressed: () {
                    if (sectorToBeAdded != "" &&
                        !getsectorStatus().keys.contains(sectorToBeAdded)) {
                      setsectorStatus(context, sectorToBeAdded, false,
                          screenHeight, screenWidth);
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
        });
  }

  //Retrieve the companies' names accoding to the input text supplied from the recommendation page
  Future<void> fetchCompanyNames() async {
    companyNameList.clear();
    companyList.clear();
    //Map<dynamic,dynamic> temp = {};
    Query query = companyRef.orderByChild("salesperson").equalTo(EmployeeName);
    DataSnapshot event = await query.get();
    Map<dynamic, dynamic> tempCompanyList =
        event.value as Map<dynamic, dynamic>;
    if (recommendationText.trim() != "") {
      for (var key in tempCompanyList.keys) {
        if (tempCompanyList[key]["name"].contains(recommendationText)) {
          companyNameList.add(tempCompanyList[key]["name"]);
        }
      }
    }
    notifyListeners();
  }

  //Calculate the distance between the origin denoted by the list _center and the destinations
  Future<void> getDistances() async {
    Dio dio = new Dio();
    List<double> destinations = [];
    for (final key in companyList.keys) {
      destinations.add(companyList[key]['latitude']);
      destinations.add(companyList[key]['longitude']);
    }
    String APIKey = "AIzaSyD7XCx32mKpV1icE8n80Z6RrknFcGV6Oqc";
    String baseUrl =
        "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=";
    for (int i = 0; i < destinations.length; i = i + 2) {
      baseUrl = baseUrl +
          destinations[i].toString() +
          "," +
          destinations[i + 1].toString() +
          "|";
    }
    baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    baseUrl = baseUrl +
        "&origins=${_center[0].toString()},${_center[1].toString()}&key=${APIKey}";
    Response response = await dio.get(baseUrl);
    List<String> distances = [];
    List<String> times = [];
    for (int i = 0; i < destinations.length / 2; i++) {
      distances.add(response.data["rows"][0]["elements"][i]["distance"]["text"]
          .toString());
      times.add(response.data["rows"][0]["elements"][i]["duration"]["text"]
          .toString());
    }
    int counter = 0;
    for (var key in companyList.keys) {
      companyList[key]["distance"] = distances[counter];
      companyList[key]["duration"] = times[counter];
      counter += 1;
    }
    distances.sort((a, b) =>
        double.parse(a.replaceAll(new RegExp(r"\D"), "").trim()).compareTo(
            double.parse(b.replaceAll(new RegExp(r"\D"), "").trim())));
    Map<dynamic, dynamic> tempCompanyList = {...companyList};
    companyList.clear();
    for (int i = 0; i < distances.length; i++) {
      for (var key in tempCompanyList.keys) {
        if (tempCompanyList[key]["distance"] == distances[i] &&
            !companyList.keys.contains(key)) {
          companyList[key] = tempCompanyList[key];
          break;
        }
      }
    }
  }

  void setFilteringTextRecommendation(String name) {
    recommendationText = name;
  }

  List<double> getCenter() {
    return _center;
  }

  void clearCompanies() {
    companyList.clear();
    companyListWidget.clear();
  }

  Map<dynamic, dynamic> getCompanyList() {
    return companyList;
  }

  Future<void> retrieveCompanies(
      BuildContext context, double screenHeight, double screenWidth) async {
    //companyListWidget.clear();
    companyList.clear();
    String queryText = listFirmTextController.text.trim();
    Query query = companyRef.orderByChild("salesperson").equalTo(EmployeeName);
    DataSnapshot event = await query.get();
    //print("Employee Name is ${EmployeeName}");
    Map<dynamic, dynamic> tempCompanyList =
        event.value as Map<dynamic, dynamic>;
    for (var key in tempCompanyList.keys) {
      if (tempCompanyList[key]["name"].contains(queryText)) {
        companyList[key] = tempCompanyList[key];
      }
    }
    renderCompanyWidgetsNoDistance(context, screenHeight, screenWidth);
    notifyListeners();
  }

  void renderCompanyWidgetsNoDistance(
      BuildContext context, double screenHeight, double screenWidth) {
    companyListWidget.clear();
    for (var company in companyList.keys) {
      companyListWidget.add(Container(
        margin: EdgeInsets.only(bottom: screenHeight / 100),
        width: screenWidth / 1.1,
        height: screenHeight / 7,
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(screenHeight / 80)),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  '/address',
                  arguments: {'companyData': companyList[company]},
                );
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    0, screenHeight / 100, 0, screenHeight / 100),
                width: screenWidth / 1.3,
                height: screenHeight / 1.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(screenWidth / 100,
                          screenHeight / 200, 0, screenHeight / 200),
                      alignment: Alignment.center,
                      child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Image.asset('assets/logo.png'),
                          radius: (screenHeight / 25)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth / 30,
                          screenHeight / 200,
                          screenWidth / 50,
                          screenHeight / 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, 0, 0, screenHeight / 200),
                            child: Text(
                              companyList[company]["name"],
                              textAlign: TextAlign.start,
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: screenHeight / 50)),
                              softWrap: false,
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 70),
                            child: Row(
                              children: [
                                Text(
                                  "${companyList[company]["province"]}, ${companyList[company]["district"]}",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontSize: screenHeight / 50)),
                                  softWrap: false,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, 0, 0, screenHeight / 200),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        right: screenWidth / 100),
                                    child: Icon(Icons.settings)),
                                Text(
                                  companyList[company]["sector"],
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontSize: screenHeight / 50)),
                                  softWrap: false,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                Icons.star,
                color: Colors.grey,
                size: screenHeight / 25,
              ),
            )
          ],
        ),
      ));
    }
    notifyListeners();
  }

  void clearWidgetList() {
    companyListWidget.clear();
    notifyListeners();
  }

  void clearListCompanyTextController() {
    listFirmTextController.text = "";
    companyListWidget.clear();
  }
}
