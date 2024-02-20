import 'dart:async';
import 'dart:convert';
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GetUserDetail {
  static List<User> userlist = [];

  static Future<List<User>> getUserDetails(String token) async {
    final response = await http.get(
      Uri.parse(AppColors.BaseUrl + "api/logged_user"),
      headers: {
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      userlist.clear();

      User user = User(
        name: data["user"]["name"] ?? "",
        email: data["user"]["email"] ?? "",
        phone_number: data["user"]["phone_number"] ?? "",
        nic: data["user"]["nic"] ?? "",
        role: data["user"]["role"] ?? "",
        profile_image_url: data["user"]["profile_image_url"] ?? "",
        vehicle_number: data["user"]["vehicle_number"] ?? "",
        vehicle_type: data["user"]["vehicle_type"] ?? "",
      );

      userlist.add(user);
    }

    return userlist;
  }
}
