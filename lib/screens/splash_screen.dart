import 'dart:async';
import 'package:familydriver/Api/Customer_Loacation_End_points.dart';
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/provider/LocationProvider.dart';
import 'package:familydriver/screens/Customer/Customer_Home_page.dart';
import 'package:familydriver/screens/Driver/Driver_Home_page.dart';
import 'package:familydriver/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late LocationProvider _locationprovider;
  late CustomerAddLocation _customerlocatio;

  int num = 0;
  String token = "";
  @override
  void initState() {
    getnumber();
    _customerlocatio = Provider.of<CustomerAddLocation>(context, listen: false);
    _locationprovider = Provider.of<LocationProvider>(context, listen: false);

    _locationprovider.getUserCodinate();
    _customerlocatio.updateLocationList(token, context);

    Timer(const Duration(seconds: 2), () async {
      //Adding New Method
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => num == 1
                ? CustomerHomepage(mytoken: token)
                : num == 2
                    ? DriverHomePage(
                        token: token,
                      )
                    : Loginpage(),
          ));
    });

    super.initState();
  }

//Adding New MEthod
  Future<void> getnumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      num = int.parse(prefs.getInt('num').toString());
      token = prefs.getString('token').toString();
    });
  }

  int numberOfMessages = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(), // Empty container to push the content upwards
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage('assets/logo.png'),
                      height: 200,
                      width: 200,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child:
                  Container(), // Empty container to push the content downwards
            ),
          ],
        ),
      ),
    );
  }

//get chat data
}
