import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practice_application/database_data.dart';
import 'package:provider/provider.dart';
import 'drawer.dart';
import 'map_data.dart';
import 'dart:math' as math;

class CompanyMap extends StatefulWidget {
  const CompanyMap({super.key});

  @override
  State<CompanyMap> createState() => CompanyMapState();
}

class CompanyMapState extends State<CompanyMap> {
  late GoogleMapController mapController;
  CameraPosition intCameraPosition = const CameraPosition(
    target: LatLng(41.10401929514817, 28.987052979996243),
    zoom: 12.0,
  );
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(
        '[ { "elementType": "geometry", "stylers": [ { "color": "#f5f5f5" } ] }, { "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#f5f5f5" } ] }, { "featureType": "administrative.country", "elementType": "geometry.fill", "stylers": [ { "color": "#631818" }, { "visibility": "on" }, { "weight": 8 } ] }, { "featureType": "administrative.country", "elementType": "geometry.stroke", "stylers": [ { "color": "#e8ec13" } ] }, { "featureType": "administrative.land_parcel", "elementType": "geometry.fill", "stylers": [ { "color": "#e7311d" } ] }, { "featureType": "administrative.land_parcel", "elementType": "labels.text.fill", "stylers": [ { "color": "#bdbdbd" } ] }, { "featureType": "administrative.locality", "elementType": "geometry.fill", "stylers": [ { "color": "#f21202" } ] }, { "featureType": "administrative.neighborhood", "elementType": "geometry.fill", "stylers": [ { "color": "#02d6f2" } ] }, { "featureType": "administrative.province", "elementType": "geometry.fill", "stylers": [ { "color": "#030202" } ] }, { "featureType": "administrative.province", "elementType": "geometry.stroke", "stylers": [ { "color": "#4b6c77" } ] }, { "featureType": "landscape.man_made", "elementType": "geometry.fill", "stylers": [ { "color": "#f0c800" }, { "visibility": "on" } ] }, { "featureType": "landscape.man_made", "elementType": "geometry.stroke", "stylers": [ { "color": "#6f5f11" } ] }, { "featureType": "landscape.natural", "elementType": "geometry.fill", "stylers": [ { "color": "#05acc2" } ] }, { "featureType": "landscape.natural.landcover", "elementType": "geometry.fill", "stylers": [ { "color": "#1fdb3e" } ] }, { "featureType": "landscape.natural.terrain", "elementType": "geometry.fill", "stylers": [ { "color": "#1d7fe7" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#eeeeee" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "poi.business", "elementType": "geometry.fill", "stylers": [ { "color": "#45e86e" } ] }, { "featureType": "poi.park", "elementType": "geometry", "stylers": [ { "color": "#e5e5e5" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "road", "elementType": "geometry", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#e89c45" } ] }, { "featureType": "road.arterial", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#dadada" } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#e84545" } ] }, { "featureType": "road.highway", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry.fill", "stylers": [ { "color": "#45e86e" } ] }, { "featureType": "road.local", "elementType": "geometry.fill", "stylers": [ { "color": "#e8b445" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "transit.line", "elementType": "geometry", "stylers": [ { "color": "#e5e5e5" } ] }, { "featureType": "transit.station", "elementType": "geometry", "stylers": [ { "color": "#eeeeee" } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#c9c9c9" } ] }, { "featureType": "water", "elementType": "geometry.fill", "stylers": [ { "color": "#4550e8" } ] }, { "featureType": "water", "elementType": "labels.text", "stylers": [ { "color": "#428e1f" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] } ]');
  }

  List<Marker> getMarkerList(double screenHeight) {
    List<Marker> markerList = [];
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
    return markerList;
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
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 6, 4, 1),
              Color.fromARGB(255, 254, 191, 52),
            ],
          )),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      height: screenHeight / 20,
                      margin: EdgeInsets.fromLTRB(
                          screenWidth / 40,
                          screenHeight / 20,
                          screenWidth / 15,
                          screenHeight / 20),
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        child: Container(
                          child: Icon(
                            Icons.menu_outlined,
                            size: screenHeight / 15,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () => _scaffoldKey.currentState!.openDrawer(),
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, screenHeight / 20, 0, 0),
                      child: Text(
                        "Yakın Şirketler",
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
                height: screenHeight / 1.35,
                child: GoogleMap(
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
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
                    ...Set<Marker>.of(getMarkerList(screenHeight)),
                    ...{
                      Marker(
                          markerId: MarkerId("MyLocation"),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRose,
                          ),
                          position: LatLng(
                              Provider.of<MapData>(context, listen: false)
                                  .locationData!
                                  .latitude!,
                              Provider.of<MapData>(context, listen: false)
                                  .locationData!
                                  .longitude!))
                    }
                  },
                ),
              ),
              Container(
                height: screenHeight / 10,
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: screenHeight / 10,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
