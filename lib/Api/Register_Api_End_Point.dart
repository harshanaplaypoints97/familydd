import 'dart:async';
import 'dart:convert';
import 'package:familydriver/Api/Login_Api_End_Point.dart';
import 'package:familydriver/constant/App_color.dart';

import 'package:familydriver/screens/Login.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RegisterApi {
  static FutureOr<void> register(
      String Customername,
      String Email,
      String phonenumber,
      String Password,
      String Role,
      String ProfileImage,
      String VehicleNumber,
      String VehicleType,
      BuildContext context) async {
    var url = Uri.parse(AppColors.BaseUrl + "api/customer/register");

    try {
      var response = await http.post(url, headers: {
        "accept": "application/json",
      }, body: {
        "name": Customername,
        "email": Email,
        "phone_number": phonenumber,
        "password": Password,
        "role": Role,
        "profile_image_url": ProfileImage,
        "vehicle_number": VehicleNumber,
        "vehicle_type": VehicleType,
      });

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // ignore: use_build_context_synchronously
      } else if (response.statusCode == 201) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Loginpage(),
            ));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.primaryColor,
            content: Center(child: Text('Registration Sucessfuly')),
          ),
        );
      } else if (response.statusCode == 422) {
      } else if (response.statusCode == 400) {
      } else if (response.statusCode == 403) {
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration Failed'),
          ),
        );
      } else {}
    } catch (e) {}
  }
}
