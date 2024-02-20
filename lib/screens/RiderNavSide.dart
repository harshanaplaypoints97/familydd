import 'package:flutter/material.dart';

class RiderNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Chathuranga Wimalasena'),
            accountEmail: Text('chathiranga123@gmailcom'),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.0),
              ),
              child: CircleAvatar(
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
              leading: Icon(Icons.favorite),
              title: Text('Favorit Drivers'),
              onTap: () => print('Fav'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificatons'),
            onTap: () => print('notifications'),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('For friend'),
            onTap: () => print('Fav'),
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
            onTap: () => print('Fav'),
          ),
        ],
      ),
    );
  }
}
