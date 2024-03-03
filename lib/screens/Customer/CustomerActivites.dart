import 'dart:async';

import 'package:familydriver/Api/CustomerHiresEndpoint.dart';
import 'package:familydriver/Api/ReqestedCard.dart';
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';
import 'package:familydriver/screens/Customer/widgets/CustomerCard.dart';
import 'package:familydriver/screens/Driver/widgets/ActivityCanclecard.dart';
import 'package:familydriver/screens/Driver/widgets/ActvityCompltedcard.dart';
import 'package:flutter/material.dart';

class CustomerActivities extends StatefulWidget {
  String token;
  CustomerActivities({Key? key, required this.token}) : super(key: key);

  @override
  State<CustomerActivities> createState() => _CustomerActivitiesState();
}

class _CustomerActivitiesState extends State<CustomerActivities>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  late StreamController<List<Reqestedcards>> _controller;
  late Stream<List<Reqestedcards>> _stream;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _controller = StreamController<List<Reqestedcards>>();
    _stream = _controller.stream;
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getAllDrivers();
    });

    // Fetch data when the widget is initialized
    getAllDrivers();
  }

  void _handleTabSelection() {
    print("Selected Tab Index: ${_tabController.index}");

    // Add any conditions or actions based on the selected tab index here
    if (_tabController.index == 0) {
      // Do something for Tab 0 (e.g., if completed)
    } else if (_tabController.index == 1) {
      // Do something for Tab 1 (e.g., if cancelled)
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.close();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> getAllDrivers() async {
    try {
      List<Reqestedcards> driversList =
          await CustomerCard.Getrides(widget.token);
      _controller.add(driversList);
    } catch (error) {
      print("Error fetching drivers: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  "Reqested",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Tab(
                child: Text(
                  "Accepted",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Tab(
                child: Text(
                  "Completed",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Tab(
                child: Text(
                  "Canceled",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          title: Text(
            'Your Activities',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(
              child: Expanded(
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

                      return ListView.builder(
                        itemCount: driversList?.length ?? 0,
                        itemBuilder: (context, index) {
                          // Add your if condition based on the selected tab index
                          if (_tabController.index == 0 &&
                              driversList![index].status.toString() ==
                                  "requested") {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: Column(
                                children: [
                                  CustomerRideCard(
                                    rideid: driversList![index].id,
                                    tolongitude:
                                        driversList![index].fromLongitude,
                                    tolatitude: driversList![index].toLatitude,
                                    token: widget.token,
                                    fromlongitude:
                                        driversList![index].fromLongitude,
                                    fromlatitude:
                                        driversList![index].fromLatitude,
                                    driverid: driversList![index].driverId,
                                    distances: driversList![index].distanceKm,
                                    customerid: driversList![index].customerId,
                                    status: 'requested',
                                    customercontactnumber:
                                        driversList![index].driver.phone_number,
                                    customername:
                                        driversList![index].driver.name,
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
                                            .toStringAsFixed(2),
                                  ),
                                ],
                              ),
                            );
                          } else if (_tabController.index == 1 &&
                              driversList![index].status.toString() ==
                                  "accepted") {
                            // Handle cancelled tab condition here
                            // ...
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Column(
                                children: [
                                  CustomerRideCard(
                                    rideid: driversList![index].id,
                                    tolongitude:
                                        driversList![index].fromLongitude,
                                    tolatitude: driversList![index].toLatitude,
                                    token: widget.token,
                                    fromlongitude:
                                        driversList![index].fromLongitude,
                                    fromlatitude:
                                        driversList![index].fromLatitude,
                                    driverid: driversList![index].driverId,
                                    distances: driversList![index].distanceKm,
                                    customerid: driversList![index].customerId,
                                    status: "accepted",
                                    customercontactnumber:
                                        driversList![index].driver.phone_number,
                                    customername:
                                        driversList![index].driver.name,
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
                                            .toStringAsFixed(2),
                                  ),
                                ],
                              ),
                            ); // Return an empty container if no match
                          } else if (_tabController.index == 2 &&
                              driversList![index].status.toString() ==
                                  "completed") {
                            // Handle cancelled tab condition here
                            // ...
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Column(
                                children: [
                                  CustomerRideCard(
                                    rideid: driversList![index].id,
                                    tolongitude:
                                        driversList![index].fromLongitude,
                                    tolatitude: driversList![index].toLatitude,
                                    token: widget.token,
                                    fromlongitude:
                                        driversList![index].fromLongitude,
                                    fromlatitude:
                                        driversList![index].fromLatitude,
                                    driverid: driversList![index].driverId,
                                    distances: driversList![index].distanceKm,
                                    customerid: driversList![index].customerId,
                                    status: "accepted",
                                    customercontactnumber:
                                        driversList![index].driver.phone_number,
                                    customername:
                                        driversList![index].driver.name,
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
                                            .toStringAsFixed(2),
                                  ),
                                ],
                              ),
                            ); // Return an empty container if no match
                          } else if (_tabController.index == 3 &&
                              driversList![index].status.toString() ==
                                  "canceled") {
                            // Handle cancelled tab condition here
                            // ...
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Column(
                                children: [
                                  CustomerRideCard(
                                    rideid: driversList![index].id,
                                    tolongitude:
                                        driversList![index].fromLongitude,
                                    tolatitude: driversList![index].toLatitude,
                                    token: widget.token,
                                    fromlongitude:
                                        driversList![index].fromLongitude,
                                    fromlatitude:
                                        driversList![index].fromLatitude,
                                    driverid: driversList![index].driverId,
                                    distances: driversList![index].distanceKm,
                                    customerid: driversList![index].customerId,
                                    status: "canceled",
                                    customercontactnumber:
                                        driversList![index].driver.phone_number,
                                    customername:
                                        driversList![index].driver.name,
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
                                            .toStringAsFixed(2),
                                  ),
                                ],
                              ),
                            ); // Return an empty container if no match
                          }

                          return Container(); // Return an empty container if no match
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
