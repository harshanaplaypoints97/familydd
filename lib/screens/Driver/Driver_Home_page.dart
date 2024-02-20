import 'package:familydriver/constant/App_color.dart';
import 'package:flutter/material.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              //Greeting Notification
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                // Greeting msg and var date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Hi Dulaa!",
                      style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      '08 Feb 2024',
                      style: TextStyle(color: AppColors.secondaryColor),
                    )
                  ],
                ),
                // Main notifications
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.notifications,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  'Are you ready for the ride ?',
                  style: TextStyle(
                      color: Colors.yellow[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(height: 30),
              ],
            ),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(50),
            //   child: Container(
            //     height: 350,
            //     color: Colors.white,
            //     child: Padding(
            //       padding: EdgeInsets.all(20),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: <Widget>[
            //           Card(
            //             elevation: 4,
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 Icon(Icons.car_crash, size: 50),
            //                 SizedBox(height: 10),
            //                 Text(
            //                   'Trip',
            //                   style: TextStyle(
            //                       fontSize: 20, fontWeight: FontWeight.bold),
            //                 ),
            //                 SizedBox(height: 5),
            //                 Text(
            //                   'At this moment',
            //                   style:
            //                       TextStyle(fontSize: 16, color: Colors.grey),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           Card(
            //             elevation: 4,
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 Icon(Icons.airplane_ticket, size: 50),
            //                 SizedBox(height: 10),
            //                 Text(
            //                   'Flight',
            //                   style: TextStyle(
            //                       fontSize: 20, fontWeight: FontWeight.bold),
            //                 ),
            //                 SizedBox(height: 5),
            //                 Text(
            //                   'Ready for takeoff',
            //                   style:
            //                       TextStyle(fontSize: 16, color: Colors.grey),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
