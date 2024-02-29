import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/screens/Customer/CustomerActivites.dart';
import 'package:familydriver/screens/Customer/Customer_Home_page.dart';
import 'package:familydriver/screens/Driver/DriverActivites.dart';
import 'package:familydriver/screens/Driver/Driver_Home_page.dart';
import 'package:flutter/material.dart';

class DriverMainPage extends StatefulWidget {
  final String token;
  DriverMainPage({super.key, required this.token});

  @override
  State<DriverMainPage> createState() => _DriverMainPageState();
}

class _DriverMainPageState extends State<DriverMainPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List _widgetOptions = [
      DriverHomePage(token: widget.token),
      DriverActvities(
        token: widget.token,
      ),
    ];
    return Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Do you want to exit from this application ? "),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // return true;
                    },
                    child: Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // return true;
                    },
                    child: Text("Yes"),
                  ),
                ],
              ),
            );
            return false;
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: _widgetOptions[_selectedIndex],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: GestureDetector(
                  child: Icon(
                Icons.dashboard,
                size: 25,
                color: _selectedIndex == 0 ? Colors.yellow : Colors.grey,
              )),
              label: "Home Page",
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  child: Icon(
                Icons.menu,
                size: 30,
                color: _selectedIndex == 1 ? Colors.yellow : Colors.grey,
              )),
              label: "Activities",
            ),
          ],
        ));
  }
}
