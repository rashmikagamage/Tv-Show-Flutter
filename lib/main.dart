import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tvshowsapp/provider/entry_provider.dart';
import 'package:tvshowsapp/screens/add_tv_show.dart';
import 'package:tvshowsapp/screens/admin_home.dart';
import 'package:tvshowsapp/screens/favourite_shows.dart';
import 'package:tvshowsapp/screens/home_screen.dart';
import 'package:tvshowsapp/screens/view_tv_show.dart';
import 'package:tvshowsapp/login/login.dart';
import 'package:tvshowsapp/login/signup.dart';
import 'package:tvshowsapp/login/start.dart';
import 'package:tvshowsapp/screens/trending_list.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid = AndroidInitializationSettings('not');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EntryProvider(),
      child: MaterialApp(
          home: Start(),
          routes: <String,WidgetBuilder>{

            "Login" : (BuildContext context)=>Login(),
            "SignUp":(BuildContext context)=>SignUp(),
            "HomeScreen":(BuildContext context)=>HomeScreeen(),
            "ListViewPage":(BuildContext context)=>ListViewPage(),
            "Start":(BuildContext context)=>Start(),

         },

          theme: ThemeData(
            accentColor: Colors.pinkAccent,
            primaryColor: Colors.black,
          )),
    );
  }
}
