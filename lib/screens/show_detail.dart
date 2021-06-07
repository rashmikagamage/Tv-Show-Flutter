import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tvshowsapp/models/show.dart';
import 'package:tvshowsapp/models/tvshow.dart';
import 'package:tvshowsapp/widgets/circular_clipper.dart';
import 'package:tvshowsapp/widgets/rating_star.dart';

class ShowDetail extends StatefulWidget {
  final Show show;
  ShowDetail({this.show});

  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  bool isFavouriteClicked = false;
  double userRating = 1.0;
  int stateuserCount;
  double total;
  double showRating;

  @override
  initState() {
    stateuserCount = int.parse(widget.show.ratedUsersCount);
    total = double.parse(widget.show.rating);
    if (total == 0) {
      showRating = 0.0;
    } else {
      showRating = double.parse((total / stateuserCount).toStringAsFixed(1));
    }
  }

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
    int count = stateuserCount + 1;

    double currentRating = total + userRating;
    double newRating = currentRating / count;

    newRating = double.parse(newRating.toStringAsFixed(1));

    double sendRating = num.parse(currentRating.toStringAsFixed(1));

    sendToDB(show, sendRating.toString(), count.toString());

    setState(() {
      stateuserCount = count;
      total = sendRating;
      showRating = newRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.show.name);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Hero(
                  tag: widget.show.imageUrl,
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: Image(
                      height: 400.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.show.imageUrl),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.only(left: 30.0),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Colors.white,
                  ),
                  Text('CeyFlix',
                      style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'muli')),
                  IconButton(
                    padding: EdgeInsets.only(right: 30.0),
                    onPressed: () {
                      setState(() {
                        isFavouriteClicked = !isFavouriteClicked;
                      });
                    },
                    icon: Icon(isFavouriteClicked
                        ? Icons.favorite
                        : Icons.favorite_border),
                    iconSize: 30.0,
                    color: Colors.white,
                  ),
                ],
              ),
              Positioned(
                bottom: 0.0,
                left: 20.0,
                child: IconButton(
                  onPressed: () => print('Add to Favourites'),
                  icon: Icon(Icons.add),
                  iconSize: 40.0,
                  color: Colors.black,
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 25.0,
                child: IconButton(
                  onPressed: () => print('Share to image'),
                  icon: Icon(Icons.share),
                  iconSize: 40.0,
                  color: Colors.black,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.show.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Center(
                    child: Text(showRating.toString(),
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StarRating(
                      rating: showRating,
                      starSize: 35,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.person,
                      color: Colors.black45,
                    ),
                    Text(
                      stateuserCount.toString(),
                      style: TextStyle(color: Colors.black45),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Available on',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16.0),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.show.channel,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'During',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16.0),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.show.day + '\'s at ' + widget.show.showTime,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        primary: Colors.blue[700],
                        textStyle: TextStyle(fontSize: 20.0)),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text('Add Rating'),
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
                                            userRating, widget.show.toEntry())),
                                    child: Text('Submit'))
                              ],
                            )),
                    child: const Text('Rate Show'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
