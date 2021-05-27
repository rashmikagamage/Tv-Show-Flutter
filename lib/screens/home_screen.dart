import 'package:flutter/material.dart';

import 'package:tvshowsapp/services/dataProvider.dart';
import 'package:tvshowsapp/widgets/day_scroll.dart';

class HomeScreeen extends StatefulWidget {
  @override
  _HomeScreeenState createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  PageController _pageController;
  var imagesList;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
    imagesList = showList.map((show) => show.imageUrl).toList();
  }

  _showSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0)
                ],
              ),
              child: Center(
                child: Hero(
                  tag: showList[index].imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: NetworkImage(showList[index].imageUrl),
                      height: 220.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 30.0,
            bottom: 40.0,
            child: Container(
              width: 250.0,
              child: Text(
                showList[index].name.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            padding: EdgeInsets.only(left: 0.0),
            onPressed: () => print('Menu'),
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            color: Colors.black),
        title: Center(
          child: Text(
            'My Tv-Shows'.toUpperCase(),
            style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.blue[900],
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'muli'),
          ),
        ),
        actions: [],
      ),
      body: ListView(
        children: [
          Container(
            height: 280.0,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                return _showSelector(index);
              },
              itemCount: showList.length,
            ),
          ),
          Container(
            height: 90.0,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    width: 160.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.indigo[900], Colors.blue[300]],
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0)
                        ]),
                    child: Center(
                      child: Text(
                        days[index].toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.8),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 20.0,
          ),
          DayScroll(
            images: imagesList,
            title: 'My List',
            imageHeight: 250.0,
            imageWidth: 150.0,
          ),
          DayScroll(
            images: imagesList,
            title: 'Favourites',
            imageHeight: 250.0,
            imageWidth: 150.0,
          ),
        ],
      ),
    );
  }
}
