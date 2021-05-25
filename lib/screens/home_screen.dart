import 'package:flutter/material.dart';
import 'package:tvshowsapp/services/firestore_services.dart';

class HomeScreeen extends StatefulWidget {
  @override
  _HomeScreeenState createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {

  PageController _pageController;

  @override
    void initState() {
      super.initState();
      _pageController = PageController(initialPage: 1,viewportFraction: 0.8);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(left: 30.0),
          onPressed: ()=>print('Menu'),
          icon:Icon(Icons.menu),
          iconSize: 30.0,
          color:Colors.black
        ),
        title: Center(
          child: Text(
            'TV-Shows'.toUpperCase(),
            style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.black45,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'muli'
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profPic.png'),
            ),
          )
        ],
      ),
    );
  }
}
