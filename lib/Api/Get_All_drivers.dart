import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';

class GetAllDrivers {
  static List<Drivers> driverlist = [];

  static Future<List<Drivers>> GetAllDriverss(String token) async {
    final response = await http.get(
      Uri.parse(AppColors.BaseUrl + "api/drivers"),
      headers: {
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      driverlist.clear();

      for (var driverData in data["drivers"]) {
        Drivers drivers = Drivers(
          name: driverData["name"] ?? "",
          email: driverData["email"] ?? "",
          email_verified_at: driverData["email_verified_at"] ?? "",
          id: driverData["id"] ?? "",
          nic: driverData["nic"] ?? "",
          phone_number: driverData["phone_number"] ?? "",
          profile_image_url: driverData["profile_image_url"] ?? "",
          role: driverData["role"] ?? "",
          status: driverData["status"] ?? "",
          vehicle_type: driverData["vehicle_type"] ?? "",
        );

        driverlist.add(drivers);
      }
    }

    return driverlist;
  }
}
