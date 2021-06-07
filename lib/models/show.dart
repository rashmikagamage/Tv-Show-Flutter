import 'package:tvshowsapp/models/tvshow.dart';

class Show {

  String id;
  String name;
  String imageUrl;
  String showTime;
  String day;
  String channel;
  String rating;
  String ratedUsersCount;


  Show(
      {
      this.id,
      this.name,
      this.imageUrl,
      this.showTime,
      this.day,
      this.channel,
      this.rating,
      this.ratedUsersCount});

  Entry toEntry(){
    return Entry(id: id,
    name: name,
    showTime: showTime,
    day: day,
    channel: channel,
    rating: rating,
    ratedUsersCount: ratedUsersCount
    );
  }
}
