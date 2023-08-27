import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapData extends ChangeNotifier {
  LocationData? currentLocation;
  Marker? currentLocationMarker;
  Location location = new Location();
  bool serviceEnabled = false;
  late PermissionStatus permissionGranted;
  LocationData? locationData;

  // Standard code for accessing the live location of the user
  Future<void> getCurrentLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();
    notifyListeners();
  }

  // Standard code for updating the current location variable when the user moves
  void updateCurrentLocation() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      locationData = currentLocation;
      notifyListeners();
    });
  }

  //Retrieve the user's location
  LocationData? getLocationData() {
    return locationData;
  }
}
