import 'package:familydriver/screens/Customer/ReqestedPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/App_color.dart';
import 'package:intl/intl.dart';

class RideShadulePage extends StatefulWidget {
  double totalprice;

  String driver_name, driver_nic, driver_contact_num;
  String token, fromloaction, tolocation;
  double startlongitude, startlatitude, endlatitude, endlongitude, Distance;
  int customerid, driveri;
  // ignore: non_constant_identifier_names
  RideShadulePage(
      {super.key,
      required this.Distance,
      required this.totalprice,
      required this.driver_contact_num,
      required this.driver_name,
      required this.driver_nic,
      required this.endlatitude,
      required this.token,
      required this.endlongitude,
      required this.startlatitude,
      required this.startlongitude,
      required this.fromloaction,
      required this.tolocation,
      required this.customerid,
      required this.driveri});

  @override
  State<RideShadulePage> createState() => _RideShadulePageState();
}

class _RideShadulePageState extends State<RideShadulePage> {
  AutovalidateMode switched = AutovalidateMode.disabled;
  TextEditingController _checkdatecontroller = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _checkdatecontroller.text =
              DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime);
        });
      }
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Details about Trip",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Center(
                child: Text(
                  "Add about Details ",
                  style: TextStyle(
                      color: AppColors.drivercardnotactive, fontSize: 14),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 320,
                height: 520,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        Container(
                          width: 270,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '  ' + widget.driver_name,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // _makePhoneCall(widget.driver_contact_num);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '   NIC - ' + widget.driver_nic,
                                style: TextStyle(fontSize: 12),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '   Contact number - ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    widget.driver_contact_num,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -24,
                          right: -28,
                          child: Image.asset(
                            "assets/DriverPic.png",
                            height: 100,
                            width: 100,
                            fit: BoxFit
                                .contain, // Ensure the image fits within the container
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Form(
                        autovalidateMode: switched,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date is required';
                            }

                            return null;
                          },
                          controller: _checkdatecontroller,
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(11.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors
                                    .grey, // Add your desired border color here
                                width: 1.0,
                              ),
                            ),
                            labelText: 'Select Date and Time',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () => _selectDateTime(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 30,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            LocationPoint(),
                            SizedBox(width: 10),
                            Text("Pickup  : " + widget.fromloaction),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.more_vert),
                    ),
                    Container(
                      height: 30,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            EndlocationPoint(),
                            SizedBox(width: 10),
                            Text("Drop   : " + widget.tolocation)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Total Distance',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.Distance.toStringAsFixed(2) + " Km",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Total Price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rs ' + widget.totalprice.toStringAsFixed(2),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   'Arrival time',
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    // Center(
                    //   child: Text(
                    //     ((double.parse(widget.Distance) / 40) * 60)
                    //             .toStringAsFixed(2) +
                    //         ' Min',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 15,
                    //         color: Colors.red),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          setState(() {
            switched = AutovalidateMode.always;
          });
          if (_checkdatecontroller.text.isNotEmpty) {
            Logger().i(_checkdatecontroller.text);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReqestedPage(
                    dateandTime: _checkdatecontroller.text,
                    ridertype: 'schedule',
                    customerid: widget.customerid,
                    distance: widget.Distance,
                    endlatitude: widget.endlatitude,
                    endlongitude: widget.endlongitude,
                    fromloaction: widget.fromloaction,
                    startlatitude: widget.startlatitude,
                    startlongitude: widget.startlongitude,
                    token: widget.token,
                    tolocation: widget.tolocation,
                    driver_id: widget.driveri,
                  ),
                ));
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          backgroundColor: Colors.blue, // Button background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            // Button border radius
          ),
        ),
        child: Text(
          'Confirm', // Button text
          style: TextStyle(
            fontSize: 18, // Button text size
            fontWeight: FontWeight.bold, // Button text weight
            color: Colors.white, // Button text color
          ),
        ),
      ),
    );
  }

  Container EndlocationPoint() {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}

class LocationPoint extends StatelessWidget {
  const LocationPoint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
