import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvshowsapp/models/show.dart';
import 'package:tvshowsapp/models/tvshow.dart';
import 'package:tvshowsapp/provider/entry_provider.dart';
import 'package:tvshowsapp/screens/admin_home.dart';
import 'package:tvshowsapp/screens/show_detail.dart';
import 'package:tvshowsapp/services/firestore_services.dart';
import 'package:tvshowsapp/widgets/side_bar.dart';
import 'package:tvshowsapp/services/dataProvider.dart';
import 'package:tvshowsapp/widgets/single_show.dart';

class HomeScreeen extends StatefulWidget {
  @override
  _HomeScreeenState createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  PageController _pageController;
  String day = 'Monday';
  FirestoreService _fs = FirestoreService();
  Set<Show> translatedList = new LinkedHashSet();
  bool isEmptyFlag = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
    // _fs.getshows();
  }

  int dayLength(List<Entry> list) {
    int dayCount = 0;
    list.forEach((element) {
      if (element.day == day) dayCount++;
    });
    if (dayCount == 0) {
      isEmptyFlag = true;
      return 1;
    }
    return dayCount;
  }

  _showSelector(int index, showList) {
    List<Show> currentList = showList.where((show) => show.day == day).toList();
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
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowDetail(show: currentList[index]))),
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
                    tag: currentList[index].imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        currentList[index].imageUrl,
                        fit: BoxFit.cover,
                        height: 220.0,
                        loadingBuilder: (BuildContext ctx, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue[700]),
                              ),
                            );
                          }
                        },
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
                  currentList[index].name.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Container(
          margin: EdgeInsets.only(left: 70.0),
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
      body: StreamBuilder(
        stream: entryProvider.entries,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView(
              children: [
                Container(
                  height: 280.0,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemBuilder: (BuildContext context, int index) {
                      for (int i = 0; i < snapshot.data.length; i++) {
                        Entry newEntry = snapshot.data[i];
                        translatedList.add(new Show(
                            id: newEntry.id,
                            name: newEntry.name,
                            imageUrl: imageUrls[i],
                            showTime: newEntry.showTime,
                            day: newEntry.day,
                            channel: newEntry.channel,
                            rating: newEntry.rating,
                            ratedUsersCount: newEntry.ratedUsersCount));
                      }
                      return isEmptyFlag
                          ? Center(
                              child: Text(
                                'No shows on $day',
                                style: TextStyle(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            )
                          : _showSelector(index, translatedList);
                    },
                    itemCount: dayLength(snapshot.data),
                  ),
                ),
                Container(
                  height: 90.0,
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: days.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TextButton(
                          onPressed: () {
                            setState(() {
                              day = days[index];
                              isEmptyFlag = false;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            width: 160.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.indigo[900],
                                    Colors.blue[300]
                                  ],
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
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SingleShow(
                  showList: snapshot.data,
                  title: 'View All',
                  imageHeight: 250.0,
                  imageWidth: 150.0,
                ),
                // DayScroll(
                //   showList: showList,
                //   title: 'Favourites',
                //   imageHeight: 300.0,
                //   imageWidth: 100.0,
                // ),
              ],
            );
          } else {
            return Center(
                child: Center(
              child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)),
            ));
          }
        },
      ),
    );
  }
}
