import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practice_application/database_data.dart';
import 'package:provider/provider.dart';
import 'drawer.dart';

class Recommend extends StatefulWidget {
  double screenHeight = 0;
  double screenWidth = 0;
  Recommend(this.screenHeight, this.screenWidth);

  @override
  State<Recommend> createState() => RecommendState();
}

class RecommendState extends State<Recommend> {
  late GoogleMapController mapController;
  CameraPosition intCameraPosition = const CameraPosition(
    target: LatLng(41.10401929514817, 28.987052979996243),
    zoom: 12.0,
  );
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedCompany;

  List<Marker> markerList = [];

  @override
  void initState() {
    super.initState();
    Provider.of<DatabaseData>(context, listen: false).setEmployeeName(context);
    Provider.of<DatabaseData>(context, listen: false).clearCompanies();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(
        '[ { "elementType": "geometry", "stylers": [ { "color": "#f5f5f5" } ] }, { "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#f5f5f5" } ] }, { "featureType": "administrative.country", "elementType": "geometry.fill", "stylers": [ { "color": "#631818" }, { "visibility": "on" }, { "weight": 8 } ] }, { "featureType": "administrative.country", "elementType": "geometry.stroke", "stylers": [ { "color": "#e8ec13" } ] }, { "featureType": "administrative.land_parcel", "elementType": "geometry.fill", "stylers": [ { "color": "#e7311d" } ] }, { "featureType": "administrative.land_parcel", "elementType": "labels.text.fill", "stylers": [ { "color": "#bdbdbd" } ] }, { "featureType": "administrative.locality", "elementType": "geometry.fill", "stylers": [ { "color": "#f21202" } ] }, { "featureType": "administrative.neighborhood", "elementType": "geometry.fill", "stylers": [ { "color": "#02d6f2" } ] }, { "featureType": "administrative.province", "elementType": "geometry.fill", "stylers": [ { "color": "#030202" } ] }, { "featureType": "administrative.province", "elementType": "geometry.stroke", "stylers": [ { "color": "#4b6c77" } ] }, { "featureType": "landscape.man_made", "elementType": "geometry.fill", "stylers": [ { "color": "#f0c800" }, { "visibility": "on" } ] }, { "featureType": "landscape.man_made", "elementType": "geometry.stroke", "stylers": [ { "color": "#6f5f11" } ] }, { "featureType": "landscape.natural", "elementType": "geometry.fill", "stylers": [ { "color": "#05acc2" } ] }, { "featureType": "landscape.natural.landcover", "elementType": "geometry.fill", "stylers": [ { "color": "#1fdb3e" } ] }, { "featureType": "landscape.natural.terrain", "elementType": "geometry.fill", "stylers": [ { "color": "#1d7fe7" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#eeeeee" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "poi.business", "elementType": "geometry.fill", "stylers": [ { "color": "#45e86e" } ] }, { "featureType": "poi.park", "elementType": "geometry", "stylers": [ { "color": "#e5e5e5" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "road", "elementType": "geometry", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#e89c45" } ] }, { "featureType": "road.arterial", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#dadada" } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#e84545" } ] }, { "featureType": "road.highway", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry.fill", "stylers": [ { "color": "#45e86e" } ] }, { "featureType": "road.local", "elementType": "geometry.fill", "stylers": [ { "color": "#e8b445" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "transit.line", "elementType": "geometry", "stylers": [ { "color": "#e5e5e5" } ] }, { "featureType": "transit.station", "elementType": "geometry", "stylers": [ { "color": "#eeeeee" } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#c9c9c9" } ] }, { "featureType": "water", "elementType": "geometry.fill", "stylers": [ { "color": "#4550e8" } ] }, { "featureType": "water", "elementType": "labels.text", "stylers": [ { "color": "#428e1f" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] } ]');
  }

  void getMarkerList(double screenHeight) {
    markerList.clear();
    Map<dynamic, dynamic> currentCompanies =
        Provider.of<DatabaseData>(context, listen: false).companyList;
    for (var key in currentCompanies.keys) {
      markerList.add(Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          markerId: MarkerId(key.toString()),
          position: LatLng(currentCompanies[key]["latitude"],
              currentCompanies[key]["longitude"]),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenHeight / 70))),
                        backgroundColor: Colors.amber,
                        title: Text(
                          'Şirketin hakkında',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Container(
                            child: Text(
                          "Şirketin adı: ${currentCompanies[key]["name"]}\nŞirketin sektörü: ${currentCompanies[key]["sector"]}\nŞirketin adresi: ${currentCompanies[key]["address"]}",
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: screenHeight / 50)),
                        )),
                        actions: <Widget>[
                          TextButton(
                              child: Text('Tamam!',
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenHeight / 50))),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ]);
                  });
                });
          }));
    }
  }

  Widget build(BuildContext context) {
    var temp =
        Provider.of<DatabaseData>(context, listen: false).getCompanyList();
    //print("Company List is ${temp}");
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
        body: Container(
            height: screenHeight,
            width: screenWidth,
            padding: EdgeInsets.fromLTRB(
                screenWidth / 20, screenHeight / 20, screenWidth / 20, 0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromARGB(255, 6, 4, 1),
                Color.fromARGB(255, 254, 191, 52),
              ],
            )),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, screenHeight / 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                child: Icon(
                                  Icons.menu_outlined,
                                  size: screenHeight / 15,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () =>
                                  _scaffoldKey.currentState!.openDrawer(),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(
                                    screenWidth / 20, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Yakın Firma Bul",
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: screenHeight / 25)),
                                  softWrap: true,
                                )),
                          ],
                        ),
                        Container(
                          width: screenWidth / 1.2,
                          height: screenHeight / 20,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenHeight / 80),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.fromLTRB(
                              0, screenHeight / 40, 0, screenHeight / 40),
                          alignment: Alignment.center,
                          child: Autocomplete<String>(
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController
                                    fieldTextEditingController,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(
                                        screenHeight / 70),
                                    border: Border.all(color: Colors.amber)),
                                padding: EdgeInsets.fromLTRB(
                                    screenWidth / 40, 0, 0, screenHeight / 100),
                                child: TextField(
                                  controller: fieldTextEditingController,
                                  focusNode: fieldFocusNode,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  style: TextStyle(
                                      fontSize: screenHeight / 50,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
                              );
                            },
                            optionsBuilder: (TextEditingValue value) async {
                              // When the field is empty
                              if (value.text.isEmpty) {
                                return [];
                              } else {
                                Provider.of<DatabaseData>(context,
                                        listen: false)
                                    .setFilteringTextRecommendation(value.text);
                                await Provider.of<DatabaseData>(context,
                                        listen: false)
                                    .fetchCompanyNames();
                                //print(
                                //    "Company Name List is ${Provider.of<DatabaseData>(context, listen: false).companyNameList}");
                                return Provider.of<DatabaseData>(context,
                                        listen: false)
                                    .companyNameList;
                              }
                            },
                            optionsViewBuilder: (BuildContext context,
                                AutocompleteOnSelected<String> onSelected,
                                Iterable<String> companies) {
                              return Material(
                                color: Colors.amber,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screenHeight / 70)),
                                child: Container(
                                  width: screenWidth / 1.2,
                                  height: screenHeight / 5,
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(10.0),
                                    itemCount: companies.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String option =
                                          companies.elementAt(index);

                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: ListTile(
                                          title: Text(option,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            onSelected: (value) async {
                              selectedCompany = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.fromLTRB(0, screenHeight / 35, 0, 0),
                          width: screenWidth / 1.4,
                          height: screenHeight / 15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              border: Border.all(
                                  color: Colors.amber,
                                  width: screenWidth / 100),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(screenHeight / 50))),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.amber,
                            ),
                            onPressed: () async {
                              //print("Selected company is ${selectedCompany}");
                              if (selectedCompany != null) {
                                await Provider.of<DatabaseData>(context,
                                        listen: false)
                                    .updateCenter(context, selectedCompany!);
                                Provider.of<DatabaseData>(context,
                                        listen: false)
                                    .renderCompanies(
                                        context, screenHeight, screenWidth);
                                getMarkerList(screenHeight);
                              }
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Container(
                                child: Text(
                              "Firma Öner",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenHeight / 40)),
                              softWrap: true,
                            )),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(screenHeight / 80)),
                          margin: EdgeInsets.fromLTRB(
                              0, screenHeight / 50, 0, screenHeight / 50),
                          height: screenHeight / 3,
                          child: GoogleMap(
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
                            markers: Provider.of<DatabaseData>(context,
                                            listen: false)
                                        .getCenter()
                                        .length >
                                    0
                                ? {
                                    ...Set<Marker>.of(markerList),
                                    ...{
                                      Marker(
                                          markerId: MarkerId("center"),
                                          icon: BitmapDescriptor
                                              .defaultMarkerWithHue(
                                            BitmapDescriptor.hueRose,
                                          ),
                                          position: LatLng(
                                              Provider.of<DatabaseData>(context,
                                                      listen: false)
                                                  .getCenter()[0],
                                              Provider.of<DatabaseData>(context,
                                                      listen: false)
                                                  .getCenter()[1]))
                                    }
                                  }
                                : {},
                          ),
                        ),
                        Consumer<DatabaseData>(
                            builder: (context, DatabaseData, child) {
                          return Container(
                              width: screenWidth / 1.1,
                              height: screenHeight / 3,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(screenHeight / 80),
                                  color: Colors.amber),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: DatabaseData.companyListWidget),
                              ));
                        }),
                      ],
                    )))));
  }
}
