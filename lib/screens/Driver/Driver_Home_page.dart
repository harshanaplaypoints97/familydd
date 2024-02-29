import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:familydriver/Api/Driver_Location_Update_End_Point.dart';
import 'package:familydriver/Api/Get_User_Detail_End_Point.dart';
import 'package:familydriver/Api/ReqestedCard.dart';
import 'package:familydriver/Api/Reqesting_End_Pointz.dart';
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';
import 'package:familydriver/provider/LocationProvider.dart';
import 'package:familydriver/screens/Driver/widgets/Reqested_Driver_card.dart';
import 'package:familydriver/screens/Driver/widgets/Shedule_driver_card.dart';
import 'package:familydriver/screens/Driver/widgets/TripStrat_Driver_card.dart';
import 'package:familydriver/screens/Driver/widgets/shadule_Complted.dart';
import 'package:familydriver/screens/Driver/widgets/shaduledrivercard.dart';
import 'package:familydriver/screens/Driver/widgets/tripAcceptedCard.dart';
import 'package:familydriver/screens/NavSidebar.dart';
import 'package:familydriver/screens/widgets/Rouned_boutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverHomePage extends StatefulWidget {
  final String token;

  const DriverHomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  ///////////////////////////////////////////////////////////////////////////
  String name = "", email = "", profileimage = "", address = "";
  /////////////////////////////////////////////////////////////////////
  int id = 0;
  late Future<List<User>> _userDetails;

  late Timer _timer;
  late StreamController<List<Reqestedcards>> _controller;
  late Stream<List<Reqestedcards>> _stream;
  final player = AudioPlayer();
  late AudioCache _audioCache;

  late LocationProvider _locationprovider;

  @override
  void initState() {
    super.initState();

    _controller = StreamController<List<Reqestedcards>>();
    _stream = _controller.stream;
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _locationprovider = Provider.of<LocationProvider>(context, listen: false);

      _locationprovider.getUserCodinate();
      getAllDrivers();
      DriverApiEndPoint.driverlocationUpdate(
          _locationprovider.position!.longitude.toString(),
          _locationprovider.position!.latitude.toString(),
          'ff',
          widget.token,
          context);
    });

    // Fetch data when the widget is initialized
    getAllDrivers();
    fetchData();
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

  Future<void> fetchData() async {
    _userDetails =
        GetUserDetail.getUserDetails(widget.token).then((List<User> data) {
      for (User user in data) {
        print('Name: ${user.name}, Email: ${user.email}' 'id  : ${user.id}');
        setState(() {
          id = user.id;
          name = user.name;
          email = user.email;
          profileimage = user.profile_image_url;
        });
      }

      return data;
    }).catchError((error) {
      print('Error fetching user details: $error');

      return <User>[];
    });
  }

  void _playNotificationSound() async {
// ...

    final player = AudioPlayer();

    for (var i = 0; i < 2; i++) {
      await player.play(
          UrlSource(
              'https://commondatastorage.googleapis.com/codeskulptor-assets/week7-brrring.m4a'),
          volume: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: NavBar(email: email, name: name, profileimage: profileimage),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // Greeting and Notification Row
            Expanded(
              child: FutureBuilder<List<User>>(
                future: _userDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(
                          color: Colors.yellow,
                        ),
                      ),
                    );
                  } else {
                    List<User> userDetails = snapshot.data!;

                    return ListView.builder(
                      itemCount: userDetails.length,
                      itemBuilder: (context, index) {
                        User user = userDetails[index];

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Hi " + user.name + " !",
                                  style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                              ],
                            ),
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
                        );
                      },
                    );
                  }
                },
              ),
            ),

            Expanded(
              flex: 4,
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
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              if (driversList![index].status.toString() ==
                                      "requested" &&
                                  (driversList![index].type.toString() ==
                                      "instant"))
                                NewRequest_dariverCard(
                                    oncancled: () {
                                      ReqestingDriver.RidesRequestUpdate(
                                        driversList![index].id,
                                        widget.token,
                                        driversList![index].customerId,
                                        driversList![index].fromLongitude,
                                        driversList![index].fromLatitude,
                                        driversList![index].toLongitude,
                                        driversList![index].toLatitude,
                                        driversList![index].distanceKm,
                                        "declined",
                                        driversList![index].fromLocation,
                                        driversList![index].toLocation,
                                        driversList![index].driverId,
                                      );
                                    },
                                    onaccept: () {
                                      ReqestingDriver.RidesRequestUpdate(
                                        driversList![index].id,
                                        widget.token,
                                        driversList![index].customerId,
                                        driversList![index].fromLongitude,
                                        driversList![index].fromLatitude,
                                        driversList![index].toLongitude,
                                        driversList![index].toLatitude,
                                        driversList![index].distanceKm,
                                        "accepted",
                                        driversList![index].fromLocation,
                                        driversList![index].toLocation,
                                        driversList![index].driverId,
                                      );
                                    },
                                    customercontactnumber: driversList![index]
                                        .customer
                                        .phoneNumber,
                                    customername:
                                        driversList![index].customer.name,
                                    datetime: driversList![index].scheduleTime,
                                    distance: driversList![index]
                                            .distanceKm
                                            .toStringAsFixed(2) +
                                        ' Km',
                                    fromlocation: driversList![index]
                                        .fromLocation
                                        .toString(),
                                    toLocation: driversList![index]
                                        .toLocation
                                        .toString(),
                                    price:
                                        (driversList![index].distanceKm * 200)
                                                .toStringAsFixed(2) +
                                            ' Km'),
                              if (driversList[index].status.toString() ==
                                      "accepted" &&
                                  (driversList![index].type.toString() ==
                                      "instant"))
                                TripAcceptedCard(
                                    onstart: () {
                                      ReqestingDriver.RidesRequestUpdate(
                                        driversList![index].id,
                                        widget.token,
                                        driversList![index].customerId,
                                        driversList![index].fromLongitude,
                                        driversList![index].fromLatitude,
                                        driversList![index].toLongitude,
                                        driversList![index].toLatitude,
                                        driversList![index].distanceKm,
                                        "in_progress",
                                        driversList![index].fromLocation,
                                        driversList![index].toLocation,
                                        driversList![index].driverId,
                                      );
                                    },
                                    onnavigate: () {
                                      navigateToLocation(
                                          driversList![index]
                                              .fromLatitude
                                              .toDouble(),
                                          driversList![index]
                                              .fromLongitude
                                              .toDouble());
                                    },
                                    customercontactnumber: driversList![index]
                                        .customer
                                        .phoneNumber,
                                    customername:
                                        driversList![index].customer.name,
                                    datetime: driversList![index].scheduleTime,
                                    distance: driversList![index]
                                            .distanceKm
                                            .toStringAsFixed(2) +
                                        ' Km',
                                    fromlocation: driversList![index]
                                        .fromLocation
                                        .toString(),
                                    toLocation: driversList![index]
                                        .toLocation
                                        .toString(),
                                    price:
                                        (driversList![index].distanceKm * 200)
                                                .toStringAsFixed(2) +
                                            ' Km'),
                              if (driversList[index].status.toString() ==
                                      "in_progress" &&
                                  (driversList![index].type.toString() ==
                                      "instant"))
                                Tripcompltedcard(
                                    onstart: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                  "Trip Complted ! ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 20),
                                                ),
                                                actions: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          'LKR ' +
                                                              (_locationprovider
                                                                          .getdistance(
                                                                              driversList![index].fromLatitude,
                                                                              driversList![index].fromLongitude,
                                                                              _locationprovider.position!.latitude,
                                                                              _locationprovider.position!.longitude)
                                                                          .toDouble() *
                                                                      200)
                                                                  .toStringAsFixed(2),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 30),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      RoundedButton(
                                                          buttonText:
                                                              "Collect Your Cash",
                                                          onPress: () {
                                                            ReqestingDriver
                                                                .RidesRequestUpdate(
                                                              driversList![
                                                                      index]
                                                                  .id,
                                                              widget.token,
                                                              driversList![
                                                                      index]
                                                                  .customerId,
                                                              driversList![
                                                                      index]
                                                                  .fromLongitude,
                                                              driversList![
                                                                      index]
                                                                  .fromLatitude,
                                                              driversList![
                                                                      index]
                                                                  .toLongitude,
                                                              driversList![
                                                                      index]
                                                                  .toLatitude,
                                                              _locationprovider
                                                                  .getdistance(
                                                                      driversList![
                                                                              index]
                                                                          .fromLatitude,
                                                                      driversList![
                                                                              index]
                                                                          .fromLongitude,
                                                                      _locationprovider
                                                                          .position!
                                                                          .latitude,
                                                                      _locationprovider
                                                                          .position!
                                                                          .longitude)
                                                                  .toDouble(),
                                                              "completed",
                                                              driversList![
                                                                      index]
                                                                  .fromLocation,
                                                              driversList![
                                                                      index]
                                                                  .toLocation,
                                                              driversList![
                                                                      index]
                                                                  .driverId,
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          color: Colors.black)
                                                    ],
                                                  ),
                                                ],
                                              ));
                                    },
                                    onnavigate: () {
                                      navigateToLocation(
                                          driversList![index]
                                              .toLatitude
                                              .toDouble(),
                                          driversList![index]
                                              .toLongitude
                                              .toDouble());
                                    },
                                    customercontactnumber: driversList![index]
                                        .customer
                                        .phoneNumber,
                                    customername:
                                        driversList![index].customer.name,
                                    datetime: driversList![index].scheduleTime,
                                    distance: driversList![index]
                                            .distanceKm
                                            .toStringAsFixed(2) +
                                        ' Km',
                                    fromlocation: driversList![index]
                                        .fromLocation
                                        .toString(),
                                    toLocation: driversList![index]
                                        .toLocation
                                        .toString(),
                                    price:
                                        (driversList![index].distanceKm * 200)
                                                .toStringAsFixed(2) +
                                            ' Km'),
                              if (driversList![index].status.toString() ==
                                      "requested" &&
                                  (driversList![index].type.toString() ==
                                      "schedule"))
                                Schedule_RiderCard(
                                    onaccept: () {
                                      ReqestingDriver.RidesRequestUpdate(
                                        driversList![index].id,
                                        widget.token,
                                        driversList![index].customerId,
                                        driversList![index].fromLongitude,
                                        driversList![index].fromLatitude,
                                        driversList![index].toLongitude,
                                        driversList![index].toLatitude,
                                        driversList![index].distanceKm,
                                        "accepted",
                                        driversList![index].fromLocation,
                                        driversList![index].toLocation,
                                        driversList![index].driverId,
                                      );
                                    },
                                    oncancled: () {
                                      ReqestingDriver.RidesRequestUpdate(
                                        driversList![index].id,
                                        widget.token,
                                        driversList![index].customerId,
                                        driversList![index].fromLongitude,
                                        driversList![index].fromLatitude,
                                        driversList![index].toLongitude,
                                        driversList![index].toLatitude,
                                        driversList![index].distanceKm,
                                        "declined",
                                        driversList![index].fromLocation,
                                        driversList![index].toLocation,
                                        driversList![index].driverId,
                                      );
                                    },
                                    customercontactnumber: driversList![index]
                                        .customer
                                        .phoneNumber,
                                    customername:
                                        driversList![index].customer.name,
                                    datetime: driversList![index].scheduleTime,
                                    distance: driversList![index]
                                            .distanceKm
                                            .toStringAsFixed(2) +
                                        ' Km',
                                    fromlocation: driversList![index]
                                        .fromLocation
                                        .toString(),
                                    toLocation: driversList![index]
                                        .toLocation
                                        .toString(),
                                    price:
                                        (driversList![index].distanceKm * 200)
                                                .toStringAsFixed(2) +
                                            ' Km'),
                              if (driversList![index].status.toString() ==
                                      "accepted" &&
                                  (driversList![index].type.toString() ==
                                      "schedule"))
                                sheduleacceptcard(
                                    onstart: () {
                                      ReqestingDriver.RidesRequestUpdate(
                                        driversList![index].id,
                                        widget.token,
                                        driversList![index].customerId,
                                        driversList![index].fromLongitude,
                                        driversList![index].fromLatitude,
                                        driversList![index].toLongitude,
                                        driversList![index].toLatitude,
                                        driversList![index].distanceKm,
                                        "in_progress",
                                        driversList![index].fromLocation,
                                        driversList![index].toLocation,
                                        driversList![index].driverId,
                                      );
                                    },
                                    onnavigate: () {
                                      navigateToLocation(
                                          driversList![index]
                                              .fromLatitude
                                              .toDouble(),
                                          driversList![index]
                                              .fromLongitude
                                              .toDouble());
                                    },
                                    customercontactnumber: driversList![index]
                                        .customer
                                        .phoneNumber,
                                    customername:
                                        driversList![index].customer.name,
                                    datetime: driversList![index].scheduleTime,
                                    distance: driversList![index]
                                            .distanceKm
                                            .toStringAsFixed(2) +
                                        ' Km',
                                    fromlocation: driversList![index]
                                        .fromLocation
                                        .toString(),
                                    toLocation: driversList![index]
                                        .toLocation
                                        .toString(),
                                    price:
                                        (driversList![index].distanceKm * 200)
                                                .toStringAsFixed(2) +
                                            ' Km'),
                              if (driversList![index].status.toString() ==
                                      "in_progress" &&
                                  (driversList![index].type.toString() ==
                                      "schedule"))
                                ShaduleCompletedCard(
                                    onstart: () {
                                      ReqestingDriver.RidesRequestUpdate(
                                        driversList![index].id,
                                        widget.token,
                                        driversList![index].customerId,
                                        driversList![index].fromLongitude,
                                        driversList![index].fromLatitude,
                                        driversList![index].toLongitude,
                                        driversList![index].toLatitude,
                                        _locationprovider
                                            .getdistance(
                                                driversList![index]
                                                    .fromLatitude,
                                                driversList![index]
                                                    .fromLongitude,
                                                _locationprovider
                                                    .position!.latitude,
                                                _locationprovider
                                                    .position!.longitude)
                                            .toDouble(),
                                        "completed",
                                        driversList![index].fromLocation,
                                        driversList![index].toLocation,
                                        driversList![index].driverId,
                                      );
                                    },
                                    onnavigate: () {
                                      navigateToLocation(
                                          driversList![index]
                                              .toLatitude
                                              .toDouble(),
                                          driversList![index]
                                              .toLongitude
                                              .toDouble());
                                    },
                                    customercontactnumber: driversList![index]
                                        .customer
                                        .phoneNumber,
                                    customername:
                                        driversList![index].customer.name,
                                    datetime: driversList![index].scheduleTime,
                                    distance: driversList![index]
                                            .distanceKm
                                            .toStringAsFixed(2) +
                                        ' Km',
                                    fromlocation: driversList![index]
                                        .fromLocation
                                        .toString(),
                                    toLocation: driversList![index]
                                        .toLocation
                                        .toString(),
                                    price:
                                        (driversList![index].distanceKm * 200)
                                                .toStringAsFixed(2) +
                                            ' Km')
                            ],
                          ),
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
