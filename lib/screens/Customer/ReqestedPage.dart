import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:familydriver/Api/Reqesting_End_Pointz.dart';
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/screens/widgets/Rouned_boutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class ReqestedPage extends StatefulWidget {
  String token, fromloaction, tolocation;
  double startlongitude, startlatitude, endlatitude, endlongitude, distance;
  int customerid, driver_id;
  ReqestedPage({
    super.key,
    required this.token,
    required this.endlatitude,
    required this.endlongitude,
    required this.startlatitude,
    required this.startlongitude,
    required this.fromloaction,
    required this.tolocation,
    required this.distance,
    required this.customerid,
    required this.driver_id,
  });

  @override
  State<ReqestedPage> createState() => _ReqestedPageState();
}

class _ReqestedPageState extends State<ReqestedPage> {
  int rideid = 0;
  @override
  void initState() {
    ridereq();

    // TODO: implement initState
    super.initState();
  }

  Future<void> RidesRequest(
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
        setState(() {
          rideid = data["ride"]["id"];
        });
      } else {
        print("Error: ${response.statusCode}");
        // Handle the error accordingly
      }
    } catch (e) {
      print("Exception: $e");
      // Handle the exception accordingly
    }
  }

  void ridereq() {
    setState(() {
      RidesRequest(
          widget.token,
          widget.startlongitude,
          widget.startlatitude,
          widget.endlongitude,
          widget.endlatitude,
          widget.distance,
          "declined",
          widget.fromloaction,
          widget.tolocation,
          widget.driver_id);

      Logger().i(rideid.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ZoomIn(
              child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(
                      color: Colors.yellow,
                      width: 2,
                    )),
                child: Center(
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        border: Border.all(
                          color: Colors.yellow,
                          width: 2,
                        )),
                    child: Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Colors.yellow,
                              width: 2,
                            )),
                        child: Center(
                          child: Container(
                            child: Image.asset(
                              'assets/DriverPic.png',
                              fit: BoxFit.cover,
                            ),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.yellow,
                                  width: 2,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Reqesting.....",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Center(
            child: LoadingAnimationWidget.newtonCradle(
              color: Colors.yellow,
              size: 100,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RoundedButton(
                buttonText: 'Cancle',
                onPress: () {
                  ReqestingDriver.RidesRequestUpdate(
                      rideid,
                      widget.token,
                      widget.customerid,
                      widget.startlongitude,
                      widget.startlatitude,
                      widget.endlongitude,
                      widget.endlatitude,
                      widget.distance,
                      'canceled',
                      widget.fromloaction,
                      widget.tolocation,
                      widget.driver_id);
                  Navigator.pop(context);
                },
                color: Colors.green),
          )
        ],
      ),
    );
  }
}
