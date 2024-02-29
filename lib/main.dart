import 'package:familydriver/Api/Customer_Loacation_End_points.dart';
import 'package:familydriver/provider/LocationProvider.dart';
import 'package:familydriver/provider/map_provider.dart';
import 'package:familydriver/screens/Customer/Drvers_List_Page.dart';
import 'package:familydriver/screens/Customer/InstanceRideConfirmPage_a.dart';
import 'package:familydriver/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LocationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => Mapprovider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CustomerAddLocation(),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
