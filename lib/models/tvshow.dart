class Entry {
  String id;
  String name;
  String showTime;
  String day;
  String channel;
  String rating;
  String ratedUsersCount;

  

  Entry({this.id, this.name, this.showTime, this.day, this.channel,this.rating,this.ratedUsersCount});

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        id: json['id'],
        name: json['name'],
        showTime: json['time'],
        day: json['day'],
        channel: json['channel'],
        rating: json['rating'] ,
        ratedUsersCount:json['ratedUsersCount']  
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'showTime': showTime,
      'day': day,
      'channel': channel,
      'rating': rating,
      'ratedUsersCount': ratedUsersCount
    };
  }
}
