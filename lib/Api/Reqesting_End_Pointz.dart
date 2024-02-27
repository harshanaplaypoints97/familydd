import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';

class ReqestingDriver {
  static Future<int> RidesRequest(
    String token,
    double fromlongitude,
    double fromlatitude,
    double tolongitude,
    double tolatitude,
    double distance,
    String status,
    String startDestination,
    String endDestination,
    int driverId,
  ) async {
    int id = 0;
    try {
      final response = await http.post(
        Uri.parse(AppColors.BaseUrl + "api/rides"),
        headers: {
          "accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: {
          "driver_id": driverId.toString(),
          "from_location": startDestination,
          "to_location": endDestination,
          "status":
              status, //requested, accepted, declined, in_progress, completed, canceled
          "from_latitude": fromlatitude.toString(),
          "from_longitude": fromlongitude.toString(),
          "to_latitude": tolatitude.toString(),
          "to_longitude": tolongitude.toString(),
          "distance_km": distance.toString(),
        },
      );

      print(response.body);

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print(data["ride"]["id"]);
        
        id = data["ride"]["id"];
        return id;
      } else {
        print("Error: ${response.statusCode}");
        // Handle the error accordingly
      }
    } catch (e) {
      print("Exception: $e");
      // Handle the exception accordingly
    }
    return id;
  }

  static Future<void> RidesRequestUpdate(
    int riderid,
    String token,
    int customerid,
    double fromlongitude,
    double fromlatitude,
    double tolongitude,
    double tolatitude,
    double distance,
    String status,
    String startDestination,
    String endDestination,
    int driverId,
  ) async {
    try {
      final response = await http.put(
        Uri.parse(AppColors.BaseUrl + "api/rides/update"),
        headers: {
          "accept": "application/json",
          'Authorization':
              'Bearer 107|oSeaaWl1qWTYv5GpAfEKWNsEOibihh3nSlYbG3l0e11d2625',
        },
        body: {
          "ride_id": riderid.toString(),
          "customer_id": customerid.toString(),
          "driver_id": driverId.toString(),
          "from_location": startDestination.toString(),
          "to_location": endDestination.toString(),
          "status": status
              .toString()
              .toString(), //requested,accepted,declined,in_progress,completed,canceled
          "from_latitude": fromlatitude.toString(),
          "from_longitude": fromlongitude.toString(),
          "to_latitude": tolatitude.toString(),
          "to_longitude": tolongitude.toString(),
          "distance_km": distance.toString()
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data["message"]);
      } else {
        print("Error: ${response.statusCode}");
        // Handle the error accordingly
      }
    } catch (e) {
      print("Exception: $e");
      // Handle the exception accordingly
    }
  }
}
