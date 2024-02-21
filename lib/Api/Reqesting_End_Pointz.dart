import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';

class ReqestingDriver {
  static List<NearByDrivers> neardriverlist = [];

  static Future<List<NearByDrivers>> getNearByDrivers(
      String token, double longitude, latitude) async {
    try {
      final response = await http.get(
        Uri.parse(AppColors.BaseUrl +
            "api/drivers/nearby?longitude=$longitude&latitude=$latitude"),
        headers: {
          "accept": "application/json",
          'Authorization':
              'Bearer 102|uTxyTGaqE1fvUyF5RwJZunIAIwVrCRh4gqo7H42p79cff263',
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        neardriverlist.clear();

        for (var driverData in data) {
          NearByDrivers driver = NearByDrivers.fromJson(driverData);
          neardriverlist.add(driver);
        }
      } else {
        print("Error: ${response.statusCode}");
        // Handle the error accordingly
      }
    } catch (e) {
      print("Exception: $e");
      // Handle the exception accordingly
    }

    return neardriverlist;
  }
}
