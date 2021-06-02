import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tvshowsapp/models/channel.dart';
import 'package:tvshowsapp/provider/entry_provider_channels.dart';
import 'package:rating_bar/rating_bar.dart';

class ViewChannel extends StatefulWidget {
  @override
  _ViewChannelState createState() => _ViewChannelState();
}

class _ViewChannelState extends State<ViewChannel> {
  // Title List Here
  var titleList = [
    "Looper",
    "Gamer",
    "GIJOE",
    "Daughter of the Wolf",
    "BloodShot",
    "Swiss Family Robinson",
    "Dong Yi"
  ];

  // Description List Here
  var descList = [
    "#TRENDING 1",
    "#TRENDING 2",
    "#TRENDING 3",
    "#TRENDING 4",
    "#TRENDING 5",
    "#TRENDING 6",
    "#TRENDING 7"
  ];

  var descList3 = [
    "on Saturdays at 7 pm",
    "on Sundays at 8 pm",
    "on Tuesday at 9 pm",
    "on Thursday at 8 pm",
    "on Weekend at 6 pm",
    "on Weekdays at 4 pm",
    "on Weekdays at 6 pm"
  ];
  var descList2 = [
    "From Channel HBO",
    "From Channel Netflix",
    "From Channel HBO",
    "From Channel ITN",
    "From Channel HBO",
    "From Channel &flix",
    "From Channel TV1"
  ];

  // Image Name List Here
  var imgList = [
    "assets/image1.jpg",
    "assets/image2.jpg",
    "assets/image3.jpg",
    "assets/image4.jpg",
    "assets/image5.jpg",
    "assets/image6.jpeg",
    "assets/image7.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    final entryproviderforchannels =
        Provider.of<EntryProviderForChannels>(context);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Image.asset("assets/grd.jpg", fit: BoxFit.cover),
          title: Text(
            "Channels List",
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
        body: StreamBuilder<List<Channel>>(
            stream: entryproviderforchannels.entries,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.vertical,
                    itemExtent: 150.0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showDialogFunc(
                              context,
                              imgList[index],
                              titleList[index],
                              descList[index],
                              descList3[index]);
                        },
                        child: Container(
                          child: Card(
                              color: Colors.white54,
                              elevation: 5,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      width: 150,
                                      height: 120,
                                      child: Image.asset(imgList[index])),
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
                                            "Channel Name " +
                                                snapshot.data[index].name,
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
                                              "Channel ID " +
                                                  snapshot
                                                      .data[index].channel_id,
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
                                            "via " +
                                                snapshot.data[index].channel_id,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.grey[700],
                                                  letterSpacing: .5,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
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
}

// This is a block of Model Dialog
showDialogFunc(context, img, title, desc, desc3) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage("assets/grd.jpg"), fit: BoxFit.cover),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            height: 320,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    img,
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      desc,
                      maxLines: 3,
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      desc3,
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
