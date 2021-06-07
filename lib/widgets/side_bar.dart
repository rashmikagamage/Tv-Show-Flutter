import 'package:flutter/material.dart';
import 'package:tvshowsapp/screens/admin_home.dart';
import 'package:tvshowsapp/screens/favourite_shows.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('John Wick'),
            accountEmail: Text('wick@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(500.0),
                child: Image.asset(
                  'assets/images/john.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
          ),
          ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('My Profile'),
              onTap: () => print('fav clic!')),
          ListTile(
              leading: Icon(Icons.favorite),
              title: Text('My Favorites'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewFovourite()))),
          ListTile(
              leading: Icon(Icons.tv),
              title: Text('Channels'),
              onTap: () => print('channels clicled!')),
          Divider(),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => print('settings clicled!')),
          ListTile(
              leading: Icon(Icons.notifications_active_outlined),
              title: Text('Notifications'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminHome()))),
          ListTile(
              leading: Icon(Icons.call),
              title: Text('Contact Us'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminHome()))),
          ListTile(
              leading: Icon(Icons.admin_panel_settings_rounded),
              title: Text('Admin Home'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminHome()))),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: () => print('sign out clicled!')),
        ],
      ),
    );
  }
}
