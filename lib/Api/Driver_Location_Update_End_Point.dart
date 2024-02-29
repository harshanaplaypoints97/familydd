import 'dart:async';
import 'dart:convert';
import 'package:familydriver/Api/Login_Api_End_Point.dart';
import 'package:familydriver/constant/App_color.dart';

import 'package:familydriver/screens/Login.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DriverApiEndPoint {
  static FutureOr<void> driverlocationUpdate(String longitude, String latitude,
      String Location, token, BuildContext context) async {
    var url = Uri.parse(AppColors.BaseUrl + "api/driver/location/update");

    try {
      var response = await http.post(url, headers: {
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      }, body: {
        "longitude": longitude,
        "latitude": latitude,
        "location": Location,
      });

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        print("location Update Sucessfully");

        // ignore: use_build_context_synchronously
      } else if (response.statusCode == 201) {
      } else if (response.statusCode == 422) {
      } else if (response.statusCode == 400) {
      } else if (response.statusCode == 403) {
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location Update Failed'),
          ),
        );
      } else {}
    } catch (e) {}
  }
}
