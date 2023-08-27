import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:practice_application/map_data.dart';
import 'auth.dart';
import 'drawer.dart';
import 'package:provider/provider.dart';
import 'login_data.dart';
import 'package:location/location.dart';
//import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double screenHeight = 0;
  double screenWidth = 0;
  bool weeklyClicked = false;
  final dayFirmDict = <int, List<String>>{};
  final dayFirmListWidget = <Widget>[];
  int dayID = DateTime.now().weekday;
  final days = ['Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma'];
  late GoogleMapController mapController;
  final lastFourWeekVisitNo = <int>[];
  final dailyFirmSelect = <bool>[];
  String selectedAddress = '';
  final databaseRef = FirebaseDatabase.instance.ref();
  final todayCoordinates = <LatLng>[];
  final todayFirmsName = <String>[];
  final todayFirmsMarkers = <Marker>[];
  final todayFirmsMarkersCol = <bool>[];
  int countTodayFirms = 0;
  LocationData? currentLocation;
  Marker? currentLocationMarker;
  bool errorDetected = false;
  late LatLng _center;
  String employeeName = "";
  String employeePosition = "";
  var profileImage;
  String userID = "";

  CameraPosition intCameraPosition = const CameraPosition(
    target: LatLng(41.10401929514817, 28.987052979996243),
    zoom: 12.0,
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(
        '[ { "elementType": "geometry", "stylers": [ { "color": "#f5f5f5" } ] }, { "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#f5f5f5" } ] }, { "featureType": "administrative.country", "elementType": "geometry.fill", "stylers": [ { "color": "#631818" }, { "visibility": "on" }, { "weight": 8 } ] }, { "featureType": "administrative.country", "elementType": "geometry.stroke", "stylers": [ { "color": "#e8ec13" } ] }, { "featureType": "administrative.land_parcel", "elementType": "geometry.fill", "stylers": [ { "color": "#e7311d" } ] }, { "featureType": "administrative.land_parcel", "elementType": "labels.text.fill", "stylers": [ { "color": "#bdbdbd" } ] }, { "featureType": "administrative.locality", "elementType": "geometry.fill", "stylers": [ { "color": "#f21202" } ] }, { "featureType": "administrative.neighborhood", "elementType": "geometry.fill", "stylers": [ { "color": "#02d6f2" } ] }, { "featureType": "administrative.province", "elementType": "geometry.fill", "stylers": [ { "color": "#030202" } ] }, { "featureType": "administrative.province", "elementType": "geometry.stroke", "stylers": [ { "color": "#4b6c77" } ] }, { "featureType": "landscape.man_made", "elementType": "geometry.fill", "stylers": [ { "color": "#f0c800" }, { "visibility": "on" } ] }, { "featureType": "landscape.man_made", "elementType": "geometry.stroke", "stylers": [ { "color": "#6f5f11" } ] }, { "featureType": "landscape.natural", "elementType": "geometry.fill", "stylers": [ { "color": "#05acc2" } ] }, { "featureType": "landscape.natural.landcover", "elementType": "geometry.fill", "stylers": [ { "color": "#1fdb3e" } ] }, { "featureType": "landscape.natural.terrain", "elementType": "geometry.fill", "stylers": [ { "color": "#1d7fe7" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#eeeeee" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "poi.business", "elementType": "geometry.fill", "stylers": [ { "color": "#45e86e" } ] }, { "featureType": "poi.park", "elementType": "geometry", "stylers": [ { "color": "#e5e5e5" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "road", "elementType": "geometry", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#e89c45" } ] }, { "featureType": "road.arterial", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#dadada" } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#e84545" } ] }, { "featureType": "road.highway", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry.fill", "stylers": [ { "color": "#45e86e" } ] }, { "featureType": "road.local", "elementType": "geometry.fill", "stylers": [ { "color": "#e8b445" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "transit.line", "elementType": "geometry", "stylers": [ { "color": "#e5e5e5" } ] }, { "featureType": "transit.station", "elementType": "geometry", "stylers": [ { "color": "#eeeeee" } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#c9c9c9" } ] }, { "featureType": "water", "elementType": "geometry.fill", "stylers": [ { "color": "#4550e8" } ] }, { "featureType": "water", "elementType": "labels.text", "stylers": [ { "color": "#428e1f" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] } ]');
  }

  @override
  void initState() {
    super.initState();

    (() async {
      try {
        await Provider.of<LoginData>(context, listen: false).initializeImage();
        employeeName =
            Provider.of<LoginData>(context, listen: false).employeeName;
        employeePosition =
            Provider.of<LoginData>(context, listen: false).employeePosition;
        profileImage =
            Provider.of<LoginData>(context, listen: false).profileImage;
        userID = Provider.of<LoginData>(context, listen: false).userID;
        setState(() {});
      } catch (error) {
        //print("Error is ${error.toString()}");
        //print("Employee has the name ${employeeName}");
        // Provider.of<LoginData>(context, listen: false).setLoginDataInitalizers(
        //     employeeName, employeePosition, profileImage, userID);
        this.errorDetected = true;
        setState(() {});
      }
    })();
    (() async {
      try {
        await initializetodayFirms();
      } catch (error) {
        this.errorDetected = true;
        setState(() {});
      }
    })();
    (() async {
      try {
        await Provider.of<MapData>(context, listen: false).getCurrentLocation();
      } catch (error) {
        this.errorDetected = true;
        setState(() {});
      }
    })();
  }

  bool getWeeklyClicked() {
    return this.weeklyClicked;
  }

  void setWeeklyClicked(bool val) {
    this.weeklyClicked = val;
    setState(() {});
  }

  void selectFirm(int index) {
    dailyFirmSelect.clear();
    todayFirmsMarkersCol.clear();
    int todayFirmNo = todayFirmsName.length;
    for (int i = 0; i < todayFirmNo; i++) {
      if (i == index) {
        dailyFirmSelect.add(true);
        todayFirmsMarkersCol.add(true);
      } else {
        dailyFirmSelect.add(false);
        todayFirmsMarkersCol.add(false);
      }
    }

    _center = todayCoordinates[index];
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        // on below line we have given positions of Location 5
        CameraPosition(
      target: _center,
      zoom: 12,
    )));

    setState(() {});
  }

  Future<void> initializetodayFirms() async {
    todayFirmsMarkers.clear();
    todayFirmsName.clear();
    todayCoordinates.clear();
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("Company").once().then((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> companies =
            dataSnapshot.value as Map<dynamic, dynamic>;
        for (var val in companies.values) {
          countTodayFirms = countTodayFirms + 1;
          todayFirmsMarkersCol.add(false);
          todayFirmsName.add(val['name']);
          todayCoordinates.add(LatLng(val['latitude'], val['longitude']));
        }
      }
      setState(() {});
    });
  }

  void initializeLastFourWeekVisitNo() {
    lastFourWeekVisitNo.clear();
    for (int i = 0; i < 4; i++) {
      lastFourWeekVisitNo.add(i + 3);
    }
  }

  void initializedayFirmDict() {
    dayFirmDict.clear();
    dayFirmDict[1] = [
      "Sinan Erdem Dome",
      "Galatasaray Lisesi",
      "Rams Park Stadyumu",
    ];
    dayFirmDict[2] = [
      "Sinan Erdem Dome",
      "Galatasaray Lisesi",
      "Rams Park Stadyumu",
    ];
    dayFirmDict[3] = [
      "Sinan Erdem Dome",
      "Galatasaray Lisesi",
      "Rams Park Stadyumu",
    ];
    dayFirmDict[4] = [
      "Sinan Erdem Dome",
      "Galatasaray Lisesi",
      "Rams Park Stadyumu",
    ];
    dayFirmDict[5] = [
      "Sinan Erdem Dome",
      "Galatasaray Lisesi",
      "Rams Park Stadyumu",
    ];
  }

  List<Widget> initializeFirmDictWidget(
      double screenHeight, double screenWidth) {
    dayFirmListWidget.clear();
    initializedayFirmDict();
    if (weeklyClicked == true) {
      for (int i = 0; i < 5; i++) {
        dayFirmListWidget.add(
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                "${days[i]}:",
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight / 40)),
                softWrap: true,
              )),
        );
        int dailyJobCount = 0;
        if (dayFirmDict[i + 1]?.length != null) {
          dailyJobCount = dayFirmDict[i + 1]!.length;
        }
        for (int j = 0; j < dailyJobCount; j++) {
          String tempVal = dayFirmDict[i + 1]![j];
          dayFirmListWidget.add(
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.circle_outlined),
                  Text(
                    tempVal,
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight / 45)),
                    softWrap: true,
                  )
                ],
              ),
            ),
          );
        }
      }
    } else {
      dayFirmListWidget.add(
        Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Bugünün şirketleri:",
              style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight / 40)),
              softWrap: true,
            )),
      );
      for (int i = 0; i < countTodayFirms; i++) {
        String tempVal = todayFirmsName[i];
        dayFirmListWidget.add(
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                GestureDetector(
                    child: dailyFirmSelect[i]
                        ? Icon(Icons.circle)
                        : Icon(Icons.circle_outlined),
                    onTap: () {
                      selectFirm(i);
                    }),
                Text(
                  tempVal,
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight / 40)),
                  softWrap: true,
                )
              ],
            ),
          ),
        );
      }
    }
    return dayFirmListWidget;
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
    if (errorDetected == true) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: screenHeight / 20),
              child: Icon(Icons.error_outline,
                  size: screenHeight / 10, color: Colors.amber)),
          Container(
            margin: EdgeInsets.only(bottom: screenHeight / 20),
            child: Text(
              "Error ",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w900,
                      fontSize: screenHeight / 20,
                      color: Colors.amber)),
            ),
          ),
          Consumer<LoginData>(builder: (context, LoginData, child) {
            return Container(
              margin: EdgeInsets.only(bottom: screenHeight / 20),
              width: screenWidth / 2,
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(color: Colors.white, width: screenWidth / 100),
                  borderRadius:
                      BorderRadius.all(Radius.circular(screenHeight / 50))),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () async {
                  await Auth().signout();
                  Navigator.popUntil(context, ModalRoute.withName("/"));
                },
                child: Container(
                    child: Text(
                  "Çıkış Yap",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Color.fromARGB(244, 251, 180, 2),
                          fontWeight: FontWeight.w700,
                          fontSize: screenHeight / 40)),
                  softWrap: true,
                )),
              ),
            );
          })
        ],
      );
    }

    Provider.of<MapData>(context, listen: false).updateCurrentLocation();
    todayFirmsMarkers.clear();
    for (int i = 0; i < countTodayFirms; i++) {
      todayFirmsMarkers.add(Marker(
        icon: todayFirmsMarkersCol[i] == false
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        markerId: MarkerId(i.toString()),
        position: todayCoordinates[i],
      ));
    }

    for (int i = 0; i < todayFirmsName.length; i++) {
      dailyFirmSelect.add(false);
    }
    setState(() {});
    initializeLastFourWeekVisitNo();
    setState(() {});

    return Scaffold(
      key: _scaffoldKey,
      drawer: MainDrawer(screenHeight, screenWidth, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding:
              EdgeInsets.fromLTRB(0, screenHeight / 20, 0, screenHeight / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 100),
                  padding: EdgeInsets.fromLTRB(
                      screenWidth / 40, 0, screenWidth / 40, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _scaffoldKey.currentState!.openDrawer(),
                        child: Container(
                          child: Icon(
                            Icons.menu_outlined,
                            color: Color.fromARGB(246, 243, 179, 2),
                            size: screenWidth / 10,
                          ),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.notification_add_outlined,
                          color: Color.fromARGB(246, 243, 179, 2),
                          size: screenWidth / 10,
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(screenWidth / 6, 0, 0, 0),
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, screenWidth / 25, 0),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: MemoryImage(
                          Provider.of<LoginData>(context, listen: false)
                              .profileImage) as ImageProvider?,
                      radius: screenHeight / 14,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${Provider.of<LoginData>(context).employeeName}\n${Provider.of<LoginData>(context).employeePosition}",
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: screenHeight / 40)),
                      softWrap: true,
                    ),
                  )
                ]),
              ),
              Container(
                  width: screenWidth / 1.5,
                  margin: EdgeInsets.fromLTRB(
                      screenWidth / 100, screenHeight / 50, 0, 0),
                  color: Color.fromARGB(255, 245, 225, 255),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenWidth / 3,
                          height: screenHeight / 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenHeight / 20)),
                            color: !getWeeklyClicked()
                                ? Color.fromARGB(245, 249, 165, 8)
                                : Color.fromARGB(247, 248, 195, 98),
                            border: Border.all(
                                color: !getWeeklyClicked()
                                    ? Color.fromARGB(245, 249, 165, 8)
                                    : Color.fromARGB(247, 248, 195, 98),
                                width: screenWidth / 100),
                          ),
                          child: TextButton(
                            onPressed: () {
                              setWeeklyClicked(false);
                            },
                            child: Text(
                              "Günlük",
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      color: getWeeklyClicked()
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenHeight / 50)),
                              softWrap: true,
                            ),
                          ),
                        ),
                        Container(
                          height: screenHeight / 15,
                          width: screenWidth / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenHeight / 20)),
                            color: getWeeklyClicked()
                                ? Color.fromARGB(245, 249, 165, 8)
                                : Color.fromARGB(247, 248, 195, 98),
                            border: Border.all(
                                color: getWeeklyClicked()
                                    ? Color.fromARGB(245, 249, 165, 8)
                                    : Color.fromARGB(247, 248, 195, 98),
                                width: screenWidth / 100),
                          ),
                          child: TextButton(
                            onPressed: () {
                              setWeeklyClicked(true);
                            },
                            child: Text(
                              "haftalık",
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      color: getWeeklyClicked()
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenHeight / 50)),
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: screenHeight / 7,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                            children: initializeFirmDictWidget(
                                screenHeight, screenWidth)),
                      ),
                    )
                  ])),
              Consumer<MapData>(builder: (context, MapData, child) {
                return Container(
                  margin: EdgeInsets.fromLTRB(
                      screenWidth / 100, 0, 0, screenHeight / 100),
                  height: screenHeight / 4,
                  width: screenWidth / 1.5,
                  child: (MapData.getLocationData() == null)
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Yükleniyor",
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight / 50)),
                                softWrap: true,
                              ),
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),
                                duration: Duration(seconds: 2),
                                builder: (context, value, _) =>
                                    CircularProgressIndicator(value: value),
                              ),
                            ],
                          ),
                        )
                      : GoogleMap(
                          gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>[
                            new Factory<OneSequenceGestureRecognizer>(
                              () => new EagerGestureRecognizer(),
                            ),
                          ].toSet(),
                          cameraTargetBounds: CameraTargetBounds.unbounded,
                          trafficEnabled: true,
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: true,
                          scrollGesturesEnabled: true,
                          compassEnabled: true,
                          rotateGesturesEnabled: true,
                          mapToolbarEnabled: true,
                          tiltGesturesEnabled: true,
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: intCameraPosition,
                          markers: {
                            ...Set<Marker>.of(todayFirmsMarkers),
                            ...{
                              Marker(
                                  markerId: MarkerId("MyLocation"),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueRose,
                                  ),
                                  position: LatLng(
                                      MapData.locationData!.latitude!,
                                      MapData.locationData!.longitude!))
                            }
                          },
                        ),
                );
              }),
              Container(
                margin: EdgeInsets.fromLTRB(
                    screenWidth / 100, 0, 0, screenHeight / 100),
                decoration: BoxDecoration(
                    color: Color.fromARGB(253, 233, 164, 3),
                    borderRadius: BorderRadius.circular(screenWidth / 50)),
                alignment: Alignment.center,
                width: screenWidth / 1.4,
                height: screenHeight / 25,
                child: Text(
                  "Aktivite Grafiği",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight / 40)),
                  softWrap: true,
                ),
              ),
              Container(
                width: screenWidth / 1.05,
                height: screenHeight / 5.5,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screenWidth / 2.3,
                      height: screenHeight / 5.5,
                      color: Colors.white,
                      child: BarChart(BarChartData(
                          titlesData: FlTitlesData(
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 1:
                                    return Text(
                                      '${dayFirmDict[1]!.length}',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 2:
                                    return Text(
                                      '${dayFirmDict[2]!.length}',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 3:
                                    return Text(
                                      '${dayFirmDict[3]!.length}',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 4:
                                    return Text(
                                      '${dayFirmDict[4]!.length}',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 5:
                                    return Text(
                                      '${dayFirmDict[5]!.length}',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  default:
                                    return Text(
                                      'val',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                }
                              },
                            )),
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 1:
                                    return Text(
                                      'Pzt',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 2:
                                    return Text(
                                      'Sal',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 3:
                                    return Text(
                                      'Çar',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 4:
                                    return Text(
                                      'Per',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 5:
                                    return Text(
                                      'Cum',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  default:
                                    return Text(
                                      'val',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                }
                              },
                            )),
                          ),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          borderData: FlBorderData(
                              border: const Border(
                            left: BorderSide(width: 5),
                            bottom: BorderSide(width: 5),
                          )),
                          groupsSpace: 10,
                          gridData: FlGridData(show: false),
                          // add bars
                          barGroups: [
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(
                                  toY: dayFirmDict[1]!.length.toDouble(),
                                  width: screenWidth / 40,
                                  color: Color.fromARGB(245, 249, 165, 8)),
                            ]),
                            BarChartGroupData(x: 2, barRods: [
                              BarChartRodData(
                                  toY: dayFirmDict[2]!.length.toDouble(),
                                  width: screenWidth / 40,
                                  color: Color.fromARGB(245, 249, 165, 8)),
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(
                                  toY: dayFirmDict[3]!.length.toDouble(),
                                  width: screenWidth / 40,
                                  color: Color.fromARGB(245, 249, 165, 8)),
                            ]),
                            BarChartGroupData(x: 4, barRods: [
                              BarChartRodData(
                                  toY: dayFirmDict[4]!.length.toDouble(),
                                  width: screenWidth / 40,
                                  color: Color.fromARGB(245, 249, 165, 8)),
                            ]),
                            BarChartGroupData(x: 5, barRods: [
                              BarChartRodData(
                                  toY: dayFirmDict[5]!.length.toDouble(),
                                  width: screenWidth / 40,
                                  color: Color.fromARGB(245, 249, 165, 8)),
                            ]),
                          ])),
                    ),
                    Container(
                      width: screenWidth / 2.3,
                      height: screenHeight / 5.5,
                      color: Colors.white,
                      child: BarChart(BarChartData(
                          titlesData: FlTitlesData(
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 1:
                                    return Text(
                                      '${lastFourWeekVisitNo[3]}',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 2:
                                    return Text(
                                      '${lastFourWeekVisitNo[2]}',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 3:
                                    return Text(
                                      '${lastFourWeekVisitNo[1]}',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 4:
                                    return Text(
                                      '${lastFourWeekVisitNo[0]}',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  default:
                                    return Text(
                                      'val',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                }
                              },
                            )),
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 1:
                                    return Text(
                                      '4H',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 2:
                                    return Text(
                                      '3H',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 3:
                                    return Text(
                                      '2H',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  case 4:
                                    return Text(
                                      '1H',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                  default:
                                    return Text(
                                      'val',
                                      style: TextStyle(
                                          fontSize: screenWidth / 40,
                                          fontWeight: FontWeight.w700),
                                    );
                                }
                              },
                            )),
                          ),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          borderData: FlBorderData(
                              border: const Border(
                            left: BorderSide(width: 5),
                            bottom: BorderSide(width: 5),
                          )),
                          groupsSpace: 10,
                          gridData: FlGridData(show: false),
                          // add bars
                          barGroups: [
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(
                                  toY: lastFourWeekVisitNo[3].toDouble(),
                                  width: screenWidth / 40,
                                  color: Color.fromARGB(245, 249, 165, 8)),
                            ]),
                            BarChartGroupData(x: 2, barRods: [
                              BarChartRodData(
                                  toY: lastFourWeekVisitNo[2].toDouble(),
                                  width: screenWidth / 40,
                                  color: Color.fromARGB(245, 249, 165, 8)),
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(
                                  toY: lastFourWeekVisitNo[1].toDouble(),
                                  width: screenWidth / 40,
                                  color: Color.fromARGB(245, 249, 165, 8)),
                            ]),
                            BarChartGroupData(x: 4, barRods: [
                              BarChartRodData(
                                  toY: lastFourWeekVisitNo[0].toDouble(),
                                  width: screenWidth / 40,
                                  color: Color.fromARGB(245, 249, 165, 8)),
                            ]),
                          ])),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(
                      screenWidth / 50, 0, screenWidth / 50, 0),
                  width: screenWidth / 1.5,
                  height: screenHeight / 25,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(screenHeight / 20)),
                    color: Color.fromARGB(255, 235, 156, 9),
                    border: Border.all(
                        color: Color.fromARGB(255, 235, 156, 9),
                        width: screenWidth / 500),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.home_filled, color: Colors.white),
                        Icon(Icons.place_rounded, color: Colors.white),
                        Icon(Icons.person_2_rounded, color: Colors.white),
                        Icon(Icons.checklist_rounded, color: Colors.white),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
