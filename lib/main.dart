import 'package:flutter/material.dart';
import 'package:tvshowsapp/tv-show/tv-show.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TvShows());
  }
}
