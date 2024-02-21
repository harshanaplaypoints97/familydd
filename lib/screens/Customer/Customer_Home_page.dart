import 'package:familydriver/Api/Customer_Loacation_End_points.dart';
import 'package:familydriver/Api/Get_User_Detail_End_Point.dart';
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/model/UserModel.dart';
import 'package:familydriver/provider/LocationProvider.dart';
import 'package:familydriver/screens/Customer/Map/Add_new_Address.dart';
import 'package:familydriver/screens/NavSidebar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'Schedule.dart';

// ignore: must_be_immutable
class CustomerHomepage extends StatefulWidget {
  String mytoken;
  CustomerHomepage({super.key, required this.mytoken});

  @override
  State<CustomerHomepage> createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {
  TextEditingController searchcontroller = TextEditingController();
  late LocationProvider _locationprovider;
  late CustomerAddLocation _customerAddLocation;
  String name = "", email = "", profileimage = "", address = "";
  int id = 0;
  late Future<List<User>> _userDetails;
  late CustomerAddLocation _customerlocatio;
  late Future<List<Locations>> _locationDetail;

  @override
  void initState() {
    _locationprovider = Provider.of<LocationProvider>(context, listen: false);
    _customerAddLocation =
        Provider.of<CustomerAddLocation>(context, listen: false);

    _customerAddLocation.updateLocationList(widget.mytoken, context);

    _locationprovider.getUserCodinate();

    _userDetails = GetUserDetail.getUserDetails(widget.mytoken);

    fetchData();
    // TODO: implement initState
    super.initState();

    // TODO: implement initState
    super.initState();
  }

  Future<void> fetchData() async {
    _userDetails =
        GetUserDetail.getUserDetails(widget.mytoken).then((List<User> data) {
      for (User user in data) {
        print('Name: ${user.name}, Email: ${user.email}' 'id  : ${user.id}');
        setState(() {
          id = user.id;
          name = user.name;
          email = user.email;
          profileimage = user.profile_image_url;
          _locationprovider.placemarks.isEmpty
              ? searchcontroller.text = ""
              : searchcontroller.text = _locationprovider.address;
        });
      }

      return data;
    }).catchError((error) {
      print('Error fetching user details: $error');

      return <User>[];
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('dd MMM yyyy').format(currentDate);
    return Scaffold(
      drawer: NavBar(email: email, name: name, profileimage: profileimage),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
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
                        child: Text('No data available'),
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
                                  Text(
                                    '$formattedDate',
                                    style: TextStyle(
                                        color: AppColors.secondaryColor),
                                  )
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

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Where do you want to go now ?',
                        style: TextStyle(
                            color: Colors.yellow[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),

              TextFormField(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddNewAdrressScreen(token: widget.mytoken, id: id),
                      ));
                },
                controller: searchcontroller,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  fontFamily: 'inter',
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                  hintText: "Search Your Address",
                  filled: true,
                  fillColor: Colors.blueGrey[100],
                  contentPadding: EdgeInsets.only(bottom: 10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 248, 249, 249),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 245, 244, 239),
                      width: 1.0,
                    ),
                  ),
                  prefix: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' Name is required';
                  }
                  return null;
                },
              ),

              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Consumer<CustomerAddLocation>(
                    builder: (context, value, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.home,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Home   ' + value.homeaddress,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 10),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.business,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Office' + value.officeaddress,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 10),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.restaurant,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Restaurant' + value.resturantaddress,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 10),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Select options",
                          style: TextStyle(
                              color: AppColors.drivercardnotactive,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          decoration:
                              BoxDecoration(color: AppColors.primaryColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddNewAdrressScreen(
                                              id: id,
                                              token: widget.mytoken,
                                            )),
                                  );

                                  // To map and get instance trip details
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.car_crash,
                                        size: 50,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                          height:
                                              10), // Adding space between icon and text
                                      Text(
                                        "Trip",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => ScheduleRide()),
                                  // );
                                  // get time and date details about the trip for scheduling
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.timelapse,
                                          size: 50,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                            height:
                                                10), // Adding space between icon and text
                                        Center(
                                          child: Text(
                                            "Schedule",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                //Navigate to contact us page
                              },
                              child: Container(
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Help',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.help,
                                        color: AppColors.drivercardnotactive,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // Trip and Scheduling area
            ],
          ),
        ),
      ),
    );
  }
}
