import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tvshowsapp/models/show.dart';
import 'package:tvshowsapp/screens/view_admin.dart';
import 'package:tvshowsapp/widgets/rating_star.dart';

class DayScroll extends StatelessWidget {
  final List<Show> showList;
  final String title;
  final double imageHeight;
  final double imageWidth;
  double userRating = 1.0;

  DayScroll({this.showList, this.title, this.imageHeight, this.imageWidth});

  void userRated(String title, double currentRating, int count, double rating) {
    count += 1;
    double newRating = currentRating + rating / count;
    print(title + ' ' + rating.toString());
    print(num.parse(newRating.toStringAsFixed(1)));
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
                                                showList[index].name,
                                                showList[index].rating,
                                                showList[index].ratedUsersCount,
                                                userRating)),
                                        child: Text('Submit'))
                                  ],
                                )),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: NetworkImage(showList[index].imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 170.0,
                        right: 10.0,
                        child: StarRating(
                          rating: showList[index].rating,
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
                              showList[index].ratedUsersCount.toString(),
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
