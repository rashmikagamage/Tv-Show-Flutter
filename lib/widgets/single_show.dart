import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tvshowsapp/models/show.dart';
import 'package:tvshowsapp/models/tvshow.dart';
import 'package:tvshowsapp/screens/view_admin.dart';
import 'package:tvshowsapp/widgets/rating_star.dart';
import 'package:tvshowsapp/services/dataProvider.dart';

class SingleShow extends StatelessWidget {
  final List<Entry> showList;
  final String title;
  final double imageHeight;
  final double imageWidth;
  double userRating = 1.0;

  SingleShow({this.showList, this.title, this.imageHeight, this.imageWidth});

  sendToDB(Entry show, String rating, String userCount) {
    Map<String, dynamic> tvShow = {
      "id": show.id,
      "name": show.name,
      "channel": show.channel,
      "day": show.day,
      "time": show.showTime,
      "img": '5b6p5Y+344GX44G+44GX44Gf77yB44GK44KB44Gn44Go44GG77yB',
      "rating": rating,
      "ratedUsersCount": userCount
    };

    FirebaseFirestore _db = FirebaseFirestore.instance;
    var options = SetOptions(merge: true);
    _db
        .collection('tvshows')
        .where("id", isEqualTo: show.id)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.set(tvShow, options);
    });

    Fluttertoast.showToast(
        msg: "Rating Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.lightBlue[400],
        textColor: Colors.black,
        fontSize: 14.0);

    // Navigator.of(context).pop();
  }

  void userRated(double userRating, Entry show) {
    int count = int.parse(show.ratedUsersCount) + 1;
    double newRating = double.parse(show.rating) + userRating / count;
    print(show.name + ' ' + newRating.toString());
    double sendRating = num.parse(newRating.toStringAsFixed(1));

    sendToDB(show, sendRating.toString(), count.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewAdmin())),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 30.0,
                ),
              )
            ],
          ),
        ),
        Container(
          height: imageHeight,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            scrollDirection: Axis.horizontal,
            itemCount: showList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                width: imageWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 6.0,
                      )
                    ]),
                child: Stack(
                  children: [
                    Container(
                      width: imageWidth,
                      height: imageHeight,
                      child: GestureDetector(
                        onLongPress: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text('Rate ${showList[index].name}'),
                                  content: RatingBar.builder(
                                    initialRating: 1,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (value) {
                                      userRating = value;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(
                                            context,
                                            userRated(
                                                userRating, showList[index])),
                                        child: Text('Submit'))
                                  ],
                                )),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            imageUrls[index],
                            fit: BoxFit.cover,
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
                    Positioned(
                        top: 170.0,
                        right: 10.0,
                        child: StarRating(
                          rating: double.parse(showList[index].rating),
                        )),
                    Positioned(
                        top: 170.0,
                        right: 110.0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            Text(
                              showList[index].ratedUsersCount,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
