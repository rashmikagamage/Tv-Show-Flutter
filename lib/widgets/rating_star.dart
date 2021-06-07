import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';

class StarRating extends StatelessWidget {
  double rating;
  double starSize;

  StarRating({this.rating, this.starSize});

  @override
  Widget build(BuildContext context) {
    return RatingBar.readOnly(
      initialRating: rating,
      isHalfAllowed: true,
      halfFilledIcon: Icons.star_half,
      filledIcon: Icons.star,
      filledColor: Colors.yellow[700],
      emptyColor: Colors.yellow[400],
      emptyIcon: Icons.star_border,
      size: starSize,
    );
  }
}
