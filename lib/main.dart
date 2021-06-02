import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvshowsapp/provider/entry_provider.dart';
import 'package:tvshowsapp/screens/add_tv_show.dart';
import 'package:tvshowsapp/screens/admin_home.dart';
import 'package:tvshowsapp/screens/view_tv_show.dart';
import 'package:tvshowsapp/login/login.dart';
import 'package:tvshowsapp/login/signup.dart';
import 'package:tvshowsapp/login/start.dart';
import 'package:tvshowsapp/screens/trending_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EntryProvider(),
      child: MaterialApp(
          home: AdminHome(),

          routes: <String,WidgetBuilder>{

            "Login" : (BuildContext context)=>Login(),
            "SignUp":(BuildContext context)=>SignUp(),
            "Start":(BuildContext context)=>Start(),
            "ListViewPage":(BuildContext context)=>ListViewPage(),
         },

          theme: ThemeData(
            accentColor: Colors.pinkAccent,
            primaryColor: Colors.black,
          )),
    );
  }
}
