import 'dart:async';

import 'package:familydriver/Api/Get_All_drivers.dart';
import 'package:familydriver/Api/NearDrivers_Detail_End_point.dart';
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';
import 'package:familydriver/screens/Customer/ReqestedPage.dart';
import 'package:familydriver/screens/Customer/InstanceRideConfirmPage_a.dart';
import 'package:familydriver/screens/Driver/widgets/DriverCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NearDriverList extends StatefulWidget {
  String token, fromloaction, tolocation;
  double startlongitude, startlatitude, endlatitude, endlongitude, distance;

  int customerid;
  NearDriverList({
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
  });

  @override
  State<NearDriverList> createState() => _NearDriverListState();
}

class _NearDriverListState extends State<NearDriverList> {
  late Timer _timer;
  late StreamController<List<NearByDrivers>> _controller;
  late Stream<List<NearByDrivers>> _stream;

  @override
  void initState() {
    super.initState();

    _controller = StreamController<List<NearByDrivers>>();
    _stream = _controller.stream;
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      // Update data every 5 minutes (adjust as needed)
      getAllDrivers(widget.startlatitude, widget.startlongitude);
    });

    // Fetch data when the widget is initialized
    getAllDrivers(widget.startlatitude, widget.startlongitude);
  }

  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer.cancel();

    // Close the stream controller when the widget is disposed
    _controller.close();

    super.dispose();
  }

  Future<void> getAllDrivers(
      double startlatitude, double startlongitude) async {
    try {
      List<NearByDrivers> driversList = await GetNearByDrivers.getNearByDrivers(
          widget.token, startlongitude, startlatitude);

      // Add the obtained list to the stream
      _controller.add(driversList);
    } catch (error) {
      // Handle errors if needed
      print("Error fetching drivers: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Select Your Near Driver",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Scaffold(
          body: Center(
            child: StreamBuilder<List<NearByDrivers>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  List<NearByDrivers>? driversList = snapshot.data;

                  // Display your UI with the driversList
                  return ListView.builder(
                    itemCount: driversList?.length ?? 0,
                    itemBuilder: (context, index) {
                      // Build your list item here
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ridedetail(
                                  customerid: widget.customerid,
                                  distance: widget.distance,
                                  endlatitude: widget.endlatitude,
                                  endlongitude: widget.endlongitude,
                                  fromloaction: widget.fromloaction,
                                  startlatitude: widget.startlatitude,
                                  startlongitude: widget.startlongitude,
                                  token: widget.token,
                                  tolocation: widget.tolocation,
                                  driverid:
                                      driversList![index].driverId.toInt(),
                                  pickup: widget.fromloaction,
                                  drop: widget.tolocation,
                                  Distance: double.parse(
                                          widget.distance.toStringAsFixed(2))
                                      .toString(),
                                  driver_age: '21',
                                  driver_contact_num: driversList![index]
                                      .phoneNumber
                                      .toString(),
                                  driver_name:
                                      driversList![index].name.toString(),
                                  driver_nic:
                                      driversList![index].nic.toString(),
                                  totalprice:
                                      double.parse(widget.distance.toString()) *
                                          200,
                                ),
                              ));
                        },
                        child: DriverCard(
                          driverimage:
                              driversList?[index].profileImageUrl ?? "",
                          drivername: driversList?[index].name ?? "",
                          drivetype: driversList?[index].vehicleType ?? "",
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
