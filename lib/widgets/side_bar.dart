import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Niroshan'),
            accountEmail: Text('test@test.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profPic.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
          ),
          ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () => print('fav clicled!')),
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
              leading: Icon(Icons.info),
              title: Text('About us'),
              onTap: () => print('about us clicled!')),
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
