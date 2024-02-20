import 'package:familydriver/constant/App_color.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class LocationProvider extends ChangeNotifier {
  // permition handling

  Future<Position> _determinePosition() async {
    bool camerapos = false;
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Position? _position;
  Position? get position => _position;
  List<Placemark> placemarks = [];
  double startlatitude = 0, stratlongitude = 0;
  double endlatitude = 0, endlongitude = 0;
  double distance = 0.0;

  //Get User Codinate

  Future<void> getUserCodinate() async {
    try {
      _position = await _determinePosition();
      notifyListeners();

      Logger().w(_position);
      placemarks = await placemarkFromCoordinates(
          _position!.latitude, _position!.longitude);
      startlatitude = _position!.latitude;
      stratlongitude = _position!.longitude;
      notifyListeners();

      Logger().wtf(placemarks.first.toJson());
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> StartPositions(double slat, slong) async {
    startlatitude = slat;
    stratlongitude = slong;
    notifyListeners();
  }

  Future<void> endPositions(double elat, elong) async {
    endlatitude = elat;
    endlongitude = elong;

    getdistance(startlatitude, stratlongitude, endlatitude, endlongitude);

    notifyListeners();
  }

  Future<void> clearendPositions() async {
    endlatitude = 0;
    endlongitude = 0;

    notifyListeners();
  }

//Get Address
  String get address =>
      "${placemarks.first.postalCode},${placemarks.first.street},${placemarks.first.postalCode},${placemarks.first.locality}";

  //Calculate Distance Meter

  void getdistance(
      double startlatitude, startlongitude, endlatitude, endlongitude) {
    try {
      distance = Geolocator.distanceBetween(
              startlatitude, startlongitude, endlatitude, endlongitude) /
          1000;
      Logger().w(distance);
      notifyListeners();
    } catch (e) {}
  }

  PolylinePoints polylinePoints = PolylinePoints();

  List<LatLng> _polyDta = [];

  List<LatLng> get polyData => _polyDta;
  //Fetch PolyLine Data

  Future<void> getployline() async {
    try {
      //Geting The Polyline Result
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyCiBivWTYU4Vc6PnlOQXGJBHOcpPNiFLmA",
          PointLatLng(startlatitude, stratlongitude),
          PointLatLng(endlatitude, endlongitude),
          travelMode: TravelMode.driving);

      if (result.points.isNotEmpty) {
        for (var element in result.points) {
          _polyDta.add(LatLng(element.latitude, element.longitude));
        }
        notifyListeners();
      }
    } catch (e) {}
  }
}
