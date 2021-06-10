import 'package:flutter/material.dart';
import 'package:tvshowsapp/login/start.dart';
import 'package:tvshowsapp/screens/admin_home.dart';
import 'package:tvshowsapp/screens/favourite_shows.dart';
import 'package:tvshowsapp/screens/trending_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SideBar extends StatefulWidget {
  @override
  _SideBar createState() => _SideBar();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _SideBar extends State<SideBar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("Start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

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
              leading: Icon(Icons.table_view),
              title: Text('Trending List'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListViewPage()))),
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
              onTap: () => signOut()),
        ],
      ),
    );
  }
}




