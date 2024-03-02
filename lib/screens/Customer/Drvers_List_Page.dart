import 'dart:async';

import 'package:familydriver/Api/Get_All_drivers.dart';
import 'package:familydriver/model/UserModel.dart';
import 'package:familydriver/screens/Customer/InstanceRideConfirmPage_a.dart';
import 'package:familydriver/screens/Customer/RideShaduleConfirmpage.dart';
import 'package:familydriver/screens/Driver/widgets/DriverCard.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/App_color.dart';

class DriverListPage extends StatefulWidget {
  String token, tolocation, fromlocation;
  int customerid;
  double distance, startlatitude, startlongitude, endlongitude, endlatitude;
  DriverListPage(
      {super.key,
      required this.token,
      required this.customerid,
      required this.endlatitude,
      required this.endlongitude,
      required this.startlatitude,
      required this.distance,
      required this.fromlocation,
      required this.startlongitude,
      required this.tolocation});

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
                                    builder: (context) => RideShadulePage(
                                          totalprice: widget.distance * 200,
                                          Distance: widget.distance,
                                          customerid: widget.customerid,
                                          driver_contact_num:
                                              driversList![index].phone_number,
                                          driver_name: driversList![index].name,
                                          driver_nic: driversList![index].nic,
                                          driveri: driversList![index].id,
                                          endlatitude: widget.endlatitude,
                                          endlongitude: widget.endlongitude,
                                          fromloaction: widget.fromlocation,
                                          startlatitude: widget.startlatitude,
                                          startlongitude: widget.startlongitude,
                                          token: widget.token,
                                          tolocation: widget.tolocation,
                                        )));
                          },
                          child: DriverCard(
                              driverimage:
                                  driversList![index].profile_image_url ?? "",
                              drivername: driversList![index].name ?? "",
                              drivetype:
                                  driversList![index].vehicle_type ?? ""));
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
