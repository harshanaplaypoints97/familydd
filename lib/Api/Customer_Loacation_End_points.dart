import 'dart:convert';

import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class CustomerAddLocation with ChangeNotifier {
  String homeaddress = "", homelatitude = "", homelongitude = "";
  String officeaddress = "", officelattude = "", officelongitude = "";
  String resturantaddress = "", resturantlattude = "", resturantlongitude = "";
  List<Locations> _locationList = [];

  List<Locations> get locationList => _locationList;

  Future<void> updateLocationList(String token, BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(AppColors.BaseUrl + "api/customer/locations"),
        headers: {
          "accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        _locationList.clear();

        for (var locationData in data) {
          Locations location = Locations(
            name: locationData["name"] ?? "",
            id: locationData["id"] ?? "",
            latitude: locationData["latitude"] ?? "",
            location: locationData["location"] ?? "",
            longitude: locationData["longitude"] ?? "",
            user_id: locationData["user_id"] ?? "",
          );
          if (locationData["name"] == "home") {
            homeaddress = locationData["location"];
            homelatitude = locationData["latitude"];
            homelongitude = locationData["longitude"];
            notifyListeners();
          } else if (locationData["name"] == "office") {
            officeaddress = locationData["location"];
            officelattude = locationData["latitude"];
            officelongitude = locationData["longitude"];
            notifyListeners();
          } else if (locationData["name"] == "office") {
            resturantaddress = locationData["location"];
            resturantlattude = locationData["latitude"];
            resturantlongitude = locationData["longitude"];
            notifyListeners();
          }

          _locationList.add(location);
          Logger().d(locationData["name"]);
        }

        notifyListeners(); // Notify listeners about the change
      }
    } catch (error) {
      // Handle error
      print('Error updating location: $error');
    }
  }

  Future<void> addlocation(String token, BuildContext context) async {
    try {
      final response = await http.post(
          Uri.parse(AppColors.BaseUrl + "api/customer/locations"),
          headers: {
            "accept": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: {
            {
              "user_id": 6,
              "name": "home",
              "location": "fort",
              "longitude": 555.76,
              "latitude": 32.2,
              "is_default": false
            }
          });

      print(response.body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
      }
    } catch (error) {
      // Handle error
      print('Error updating location: $error');
    }
  }
}
