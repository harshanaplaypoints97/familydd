import 'package:familydriver/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class NavBar extends StatefulWidget {
  String profileimage, name, email;
  NavBar(
      {super.key,
      required this.email,
      required this.name,
      required this.profileimage});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Expanded(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              //User Details Fetching
              UserAccountsDrawerHeader(
                accountName: Text(widget.name),
                accountEmail: Text(widget.email),
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                  child: CircleAvatar(
                    child: ClipOval(
                      child: widget.profileimage == ""
                          ? Image.asset(
                              'assets/Vector propic.jpg',
                              width: 86, // adjusted to accommodate border
                              height: 86, // adjusted to accommodate border
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              widget.profileimage,
                            ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/NavCover.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () => print('Profile'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notificatons'),
                onTap: () => print('notifications'),
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favorite Drivers'),
                onTap: () => print('Favorite Drivers'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Policies'),
                onTap: () => print('Fav'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () => print('Fav'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log out'),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Loginpage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
