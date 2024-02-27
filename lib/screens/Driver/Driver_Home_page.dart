import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:familydriver/Api/ReqestedCard.dart';
import 'package:familydriver/Api/Reqesting_End_Pointz.dart';
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';
import 'package:familydriver/screens/widgets/Rouned_boutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverHomePage extends StatefulWidget {
  final String token;

  const DriverHomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  late Timer _timer;
  late StreamController<List<Reqestedcards>> _controller;
  late Stream<List<Reqestedcards>> _stream;
  final player = AudioPlayer();
  late AudioCache _audioCache;

  @override
  void initState() {
    super.initState();

    _controller = StreamController<List<Reqestedcards>>();
    _stream = _controller.stream;
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getAllDrivers();
    });

    // Fetch data when the widget is initialized
    getAllDrivers();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.close();
    super.dispose();
  }

  Future<void> getAllDrivers() async {
    try {
      List<Reqestedcards> driversList =
          await Reqestedcard.Gethires(widget.token);
      _controller.add(driversList);
    } catch (error) {
      print("Error fetching drivers: $error");
    }
  }

  void _playNotificationSound() async {
// ...

    final player = AudioPlayer();
    await player.play(
        UrlSource(
            'https://commondatastorage.googleapis.com/codeskulptor-assets/week7-brrring.m4a'),
        volume: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // Greeting and Notification Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Greeting message and date
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Hi Tira!",
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          '08 Feb 2024',
                          style: TextStyle(color: AppColors.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                  // Notifications Icon
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
              SizedBox(height: 20),

              Expanded(
                child: StreamBuilder<List<Reqestedcards>>(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      List<Reqestedcards>? driversList = snapshot.data;

                      for (var i = 0; i < driversList!.length; i++) {
                        if (driversList![i].status.toString() == "requested") {
                          _playNotificationSound();
                        }
                      }

                      return ListView.builder(
                        itemCount: driversList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              if (driversList![index].status.toString() ==
                                  "requested")
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: InkWell(
                                    onTap: () {
                                      _playNotificationSound();
                                    },
                                    child: Container(
                                      width: 500,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 20,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                'New Request',
                                                style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'From  ' +
                                                  driversList![index]
                                                      .fromLocation
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              'To       ' +
                                                  driversList![index]
                                                      .toLocation
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              'Distance      ' +
                                                  driversList![index]
                                                      .distanceKm
                                                      .toStringAsFixed(2) +
                                                  ' Km',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              'Price      ' +
                                                  (driversList![index]
                                                              .distanceKm *
                                                          200)
                                                      .toStringAsFixed(2) +
                                                  ' Rs',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 10,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      print(
                                                          "Reject button tapped");
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      width: 150,
                                                      child: RoundedButton(
                                                        buttonText: "declined",
                                                        onPress: () {
                                                          ReqestingDriver
                                                              .RidesRequestUpdate(
                                                            driversList![index]
                                                                .id,
                                                            widget.token,
                                                            driversList![index]
                                                                .customerId,
                                                            driversList![index]
                                                                .fromLongitude,
                                                            driversList![index]
                                                                .fromLatitude,
                                                            driversList![index]
                                                                .toLongitude,
                                                            driversList![index]
                                                                .toLatitude,
                                                            driversList![index]
                                                                .distanceKm,
                                                            "declined",
                                                            driversList![index]
                                                                .fromLocation,
                                                            driversList![index]
                                                                .toLocation,
                                                            driversList![index]
                                                                .driverId,
                                                          );
                                                        },
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    height: 50,
                                                    width: 150,
                                                    child: RoundedButton(
                                                      buttonText: "Confirm",
                                                      onPress: () {
                                                        print("g");
                                                        ReqestingDriver
                                                            .RidesRequestUpdate(
                                                          driversList![index]
                                                              .id,
                                                          widget.token,
                                                          driversList![index]
                                                              .customerId,
                                                          driversList![index]
                                                              .fromLongitude,
                                                          driversList![index]
                                                              .fromLatitude,
                                                          driversList![index]
                                                              .toLongitude,
                                                          driversList![index]
                                                              .toLatitude,
                                                          driversList![index]
                                                              .distanceKm,
                                                          "accepted",
                                                          driversList![index]
                                                              .fromLocation,
                                                          driversList![index]
                                                              .toLocation,
                                                          driversList![index]
                                                              .driverId,
                                                        );
                                                      },
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (driversList[index].status.toString() ==
                                  "accepted")
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 500,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 20,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                'On Going',
                                                style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'From  ' +
                                                  driversList![index]
                                                      .fromLocation
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              'To       ' +
                                                  driversList![index]
                                                      .toLocation
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              'Distance      ' +
                                                  driversList![index]
                                                      .distanceKm
                                                      .toStringAsFixed(2) +
                                                  ' Km',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              'Price      ' +
                                                  (driversList![index]
                                                              .distanceKm *
                                                          200)
                                                      .toStringAsFixed(2) +
                                                  ' Rs',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 10,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 150,
                                                    child: RoundedButton(
                                                      buttonText: "Complete",
                                                      onPress: () {
                                                        ReqestingDriver
                                                            .RidesRequestUpdate(
                                                          driversList![index]
                                                              .id,
                                                          widget.token,
                                                          driversList![index]
                                                              .customerId,
                                                          driversList![index]
                                                              .fromLongitude,
                                                          driversList![index]
                                                              .fromLatitude,
                                                          driversList![index]
                                                              .toLongitude,
                                                          driversList![index]
                                                              .toLatitude,
                                                          driversList![index]
                                                              .distanceKm,
                                                          "completed",
                                                          driversList![index]
                                                              .fromLocation,
                                                          driversList![index]
                                                              .toLocation,
                                                          driversList![index]
                                                              .driverId,
                                                        );
                                                      },
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    height: 50,
                                                    width: 150,
                                                    child: RoundedButton(
                                                      buttonText: "Navigation",
                                                      onPress: () {
                                                        print("g");
                                                        navigateToLocation(
                                                            driversList![index]
                                                                .toLatitude
                                                                .toDouble(),
                                                            driversList![index]
                                                                .toLongitude
                                                                .toDouble());
                                                      },
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),

              // Ride Request Section
            ],
          ),
        ),
      ),
    );
  }

  void navigateToLocation(double latitude, double longitude) async {
    String url =
        "https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch Google Maps");
    }
  }
}
