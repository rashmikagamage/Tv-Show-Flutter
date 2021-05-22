import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvshowsapp/provider/entry_provider.dart';
import 'package:tvshowsapp/screens/add_tv_show.dart';
import 'package:tvshowsapp/screens/view_tv_show.dart';

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
          home: ViewTvShow(),
          theme: ThemeData(
            accentColor: Colors.pinkAccent,
            primaryColor: Colors.black,
          )),
    );
  }
}
