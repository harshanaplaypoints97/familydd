import 'dart:async';

import 'package:familydriver/Api/Get_All_drivers.dart';
import 'package:familydriver/model/UserModel.dart';
import 'package:familydriver/screens/Customer/RideConfirmPage_a.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/App_color.dart';

class DriverListPage extends StatefulWidget {
  String token;
  DriverListPage({super.key, required this.token});

  @override
  State<DriverListPage> createState() => _DriverListPageState();
}

class _DriverListPageState extends State<DriverListPage> {
  late StreamController<List<Drivers>> _controller;
  late Stream<List<Drivers>> _stream;

  @override
  void initState() {
    super.initState();

    _controller = StreamController<List<Drivers>>();
    _stream = _controller.stream;

    // Fetch data when the widget is initialized
    getAllDrivers();
  }

  Future<void> getAllDrivers() async {
    try {
      List<Drivers> driversList =
          await GetAllDrivers.GetAllDriverss(widget.token);

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
          "Select Your  Driver",
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
            child: StreamBuilder<List<Drivers>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  List<Drivers>? driversList = snapshot.data;

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
                                  Distance: "25",
                                  totalprice: 523.00,
                                  driver_age: "",
                                  driver_contact_num:
                                      driversList![index].phone_number,
                                  driver_name: driversList![index].name,
                                  driver_nic: driversList![index].nic,
                                ),
                              ));
                        },
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
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  flex: 4,
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
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      ),
                                                      //can Drvie Vehicle Type
                                                      Text(
                                                        driversList?[index]
                                                                .vehicle_type ??
                                                            "",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      ),
                                                      //Drver Phone Number
                                                      Text(
                                                        driversList?[index]
                                                                .phone_number ??
                                                            "",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      ),
                                                      //Drver Status
                                                      Text(
                                                        driversList?[index]
                                                                .status ??
                                                            "",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      ),
                                                      Text(
                                                        '"Experienced and safety-focused driver with a flawlessddddddd driving record hfewihfeifhiefhefiheihfheuhfuhekfheikfhuehfejshefoefhifhehfheofoehfoifhfhand expertise in navigating diverse road conditions. Skilled in efficient route planning and adept at delivering exceptional customer service. Reliable team player with a strong commitment to on-time performance.ssssssssssssssssssss"',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                        // textAlign: TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 3, child: Container())
                                              ],
                                            ),
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
                                        height: 250,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )
                                  ],
                                )
                              ],
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

      /*floatingActionButton:FloatingActionButton.extended(  
        onPressed: () {},  
        icon: Icon(Icons.save),  
        label: Text("Save"),  
      ), */
    );
  }
}
