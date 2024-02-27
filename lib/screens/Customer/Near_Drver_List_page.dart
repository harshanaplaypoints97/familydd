import 'dart:async';

import 'package:familydriver/Api/Get_All_drivers.dart';
import 'package:familydriver/Api/NearDrivers_Detail_End_point.dart';
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';
import 'package:familydriver/screens/Customer/ReqestedPage.dart';
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
                                builder: (context) => ReqestedPage(
                                 
                                  customerid: widget.customerid,
                                  distance: widget.distance,
                                  endlatitude: widget.endlatitude,
                                  endlongitude: widget.endlongitude,
                                  fromloaction: widget.fromloaction,
                                  startlatitude: widget.startlatitude,
                                  startlongitude: widget.startlongitude,
                                  token: widget.token,
                                  tolocation: widget.tolocation,
                                  driver_id:
                                      driversList![index].driverId.toInt(),
                                ),
                              ));
                        },
                        child: Container(
                          child: Container(
                            width: 380,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        width: 350,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0),
                                          child: Container(
                                            width: 350,
                                            decoration: BoxDecoration(
                                              color: AppColors.drivercardactive,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25),
                                                bottomLeft: Radius.circular(25),
                                                bottomRight: Radius.zero,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  flex: 4,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        //Name Of The Driver
                                                        Text(
                                                          driversList?[index]
                                                                  .name ??
                                                              "",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16),
                                                        ),
                                                        //can Drvie Vehicle Type
                                                        Text(
                                                          driversList?[index]
                                                                  .vehicleType ??
                                                              "",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16),
                                                        ),
                                                        //Drver Phone Number
                                                        Text(
                                                          driversList?[index]
                                                                  .phoneNumber ??
                                                              "",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16),
                                                        ),
                                                        //Drver Status
                                                        Text(
                                                          driversList?[index]
                                                                  .status ??
                                                              "",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16),
                                                        ),

                                                        //Driver Loacation
                                                        Text(
                                                          driversList?[index]
                                                                  .location ??
                                                              "",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16),
                                                        ),

                                                        Text(
                                                          driversList?[index]
                                                                  .status ??
                                                              "",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16),
                                                        ),
                                                        // Padding(
                                                        //   padding:
                                                        //       const EdgeInsets.all(
                                                        //           11.0),
                                                        //   child: Text(
                                                        //     '"Experienced and safety-focused driver with a flawlessddddddd driving record hfewihfeifhiefhefiheihfheuhfuhekfheikfhuehfejshefoefhifhehfheofoehfoifhfhand expertise in navigating diverse road conditions. Skilled in efficient route planning and adept at delivering exceptional customer service. Reliable team player with a strong commitment to on-time performance.ssssssssssssssssssss"',
                                                        //     style: TextStyle(
                                                        //         color: Colors.white,
                                                        //         fontSize: 12),
                                                        //     // textAlign: TextAlign.justify,
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 3, child: Container())
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 75,
                                        child: Image.asset(
                                          'assets/DriverPic.png',
                                          width: 160,
                                          height: 150,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () => {},
      ),
      /*floatingActionButton:FloatingActionButton.extended(  
        onPressed: () {},  
        icon: Icon(Icons.save),  
        label: Text("Save"),  
      ), */
    );
  }
}
