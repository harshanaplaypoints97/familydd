import 'package:familydriver/constant/App_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DriverCard extends StatefulWidget {
  String driverimage, drivername, drivetype;
  DriverCard(
      {super.key,
      required this.driverimage,
      required this.drivername,
      required this.drivetype});

  @override
  State<DriverCard> createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 250,
        width: 350,
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 330,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.drivercardactive,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 29,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    // profile img
                    child: ClipOval(
                      child: Image.asset(
                        'assets/propic2.jpg',
                        width: 86, // adjusted to accommodate border
                        height: 86, // adjusted to accommodate border
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 24,
                child: Text(
                  widget.drivername,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                top: 85,
                left: 24,
                child: const Text(
                  'Platinum Driver',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                  top: 115,
                  left: 35,
                  child: Text(
                    "Pick me,I'm promised to be your \nbest Driver ",
                    style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              Positioned(
                  top: 160,
                  left: 24,
                  child: Text(
                    widget.drivetype == "Both"
                        ? "And I'm familiar with\nAuto & Manual vehicle types!"
                        : widget.drivetype == "Auto"
                            ? "And I'm familiar with\nAuto vehicle types!"
                            : "And I'm familiar with\nManual vehicle types!",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
              Positioned(
                  top: 180,
                  left: 230,
                  child: Row(
                    children: [
                      // Aiye rating danawanm methanin danna pluwan
                      // ElevatedButton(
                      //   onPressed: () {},
                      //   child: Center(
                      //     child: Row(
                      //       children: [
                      //         Text("Select"),
                      //       ],
                      //     ),
                      //   ),
                      // )
                      Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          "Select",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        )),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
