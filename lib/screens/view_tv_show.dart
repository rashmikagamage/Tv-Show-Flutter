import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tvshowsapp/models/tvshow.dart';
import 'package:tvshowsapp/provider/entry_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_bar/rating_bar.dart';

import '../main.dart';

class ViewTvShow extends StatefulWidget {
  @override
  _ViewTvShowState createState() => _ViewTvShowState();
}

class _ViewTvShowState extends State<ViewTvShow> {
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Image.asset("assets/grd.jpg", fit: BoxFit.cover),
          title: Text(
            "Search Tv Show",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: Colors.grey[900], letterSpacing: .5, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), color: Colors.white),
            IconButton(icon: Icon(Icons.more_vert), color: Colors.white)
          ],
        ),
        body: StreamBuilder<List<Entry>>(
            stream: entryProvider.entries,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.vertical,
                    itemExtent: 150.0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _showMyDialog(
                              snapshot.data[index].id,
                              snapshot.data[index].day,
                              snapshot.data[index].name,
                              snapshot.data[index].channel,
                              snapshot.data[index].showTime);
                        },
                        child: Container(
                          child: Card(
                              color: Colors.white54,
                              elevation: 5,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      width: 100,
                                      height: 120,
                                      child: Image.asset('assets/img' +
                                          (index + 1).toString() +
                                          '.jpg')),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data[index].name,
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.indigo[900],
                                                letterSpacing: .5,
                                                fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 150,
                                          child: Text(
                                            "Watch on " +
                                                snapshot.data[index].day,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.grey[850],
                                                  letterSpacing: .5,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Container(
                                            child: Text(
                                              "Catch it @ " +
                                                  snapshot.data[index].showTime,
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.grey[850],
                                                    letterSpacing: .5,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "On channel " +
                                                snapshot.data[index].channel,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.grey[700],
                                                  letterSpacing: .5,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Row(children: <Widget>[
                                            RatingBar.readOnly(
                                              initialRating: 5 - index + 0.0,
                                              isHalfAllowed: true,
                                              halfFilledIcon: Icons.star_half,
                                              filledIcon: Icons.star,
                                              filledColor: Colors.green[700],
                                              emptyColor: Colors.green[400],
                                              emptyIcon: Icons.star_border,
                                              size: 17,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 150),
                                              child: Icon(
                                                Icons.notifications_none,
                                                color: Colors.pink[800],
                                                size: 24.0,
                                              ),
                                            ),
                                          ]),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    });
              } else {
                return Center(
                    child: new Container(
                        child:
                            Text('Loading', style: TextStyle(fontSize: 25))));
              }
            }));
  }

  Future<void> _showMyDialog(
      String id, String day, String name, String channel, String time) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return BounceInUp(
          child: AlertDialog(
            title: Text(
              "Don't ever miss  Tv-Show",
              style: TextStyle(fontSize: 18, color: Colors.blue[900]),
            ),
            content: SingleChildScrollView(
              child: Column(children: <Widget>[
                Image(image: AssetImage('assets/email.gif')),
                Text(
                  'Confirm to get notification for $name ',
                  style: TextStyle(
                      fontSize: 16, color: Colors.grey[900], height: 1.75),
                ),
                Text(
                  'You will get a Notification and a mobile alert',
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey[800], height: 1.75),
                ),
              ]),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Confirm'),
                onPressed: () {
                  scheduleAlarm(name, channel, time);
                  addToDB(id, name, channel, day, time);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //method to schedule the alarm
  void scheduleAlarm(String name, String channel, String time) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'not',
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(
        5,
        "Reminder to watch " + name,
        " Watch it @ " + time + " on " + channel,
        DateTime.now(),
        platformChannelSpecifics);
  }
}

//method to add favourite tv-shows to DB

addToDB(String id, String name, String channel, String day, String time) {
  Map<String, dynamic> demo = {
    "userid": "rashmikamadushan321@gmail.com",
    "id": id,
    "name": name,
    "channel": channel,
    "day": day,
    "time": time,
    "img": '5b6p5Y+344GX44G+44GX44Gf77yB44GK44KB44Gn44Go44GG77yB'
  };

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('favourites');
  collectionReference.add(demo);
}
