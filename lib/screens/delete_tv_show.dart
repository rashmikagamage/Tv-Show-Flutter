import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvshowsapp/models/tvshow.dart';
import 'package:tvshowsapp/provider/entry_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_bar/rating_bar.dart';

class DeleteShow extends StatefulWidget {
  @override
  _DeleteShowState createState() => _DeleteShowState();
}

class _DeleteShowState extends State<DeleteShow> {
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Image.asset("assets/grd.jpg", fit: BoxFit.cover),
          title: Text(
            "Admin Panel",
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
                          _showMyDialog(snapshot.data[index].id, entryProvider,
                              snapshot.data[index].name);
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
                                                  left: 120),
                                              child: Icon(
                                                Icons.delete_outline,
                                                color: Colors.red[800],
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
                return new Container(child: Text('Loading'));
              }
            }));
  }

  Future<void> _showMyDialog(String id, final entry, String name) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete',
            style: TextStyle(fontSize: 20, color: Colors.grey[900]),
          ),
          content: SingleChildScrollView(
            child: Container(child: Text('Confirm to delete $name')),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                entry.removeEntry(id);
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
        );
      },
    );
  }
}
