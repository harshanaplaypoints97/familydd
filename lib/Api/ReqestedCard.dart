import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';

class Reqestedcard {
  static List<Reqestedcards> neardriverlist = [];

  static Future<List<Reqestedcards>> Gethires(
    String token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(AppColors.BaseUrl + "api/rides/driver"),
        headers: {
          "accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        neardriverlist.clear();

        for (var driverData in data) {
          Reqestedcards driver = Reqestedcards.fromJson(driverData);
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
