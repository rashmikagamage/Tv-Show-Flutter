class Entry {
  String id;
  String name;
  String showTime;
  String day;
  String channel;

  Entry({this.id, this.name, this.showTime, this.day, this.channel});

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        id: json['id'],
        name: json['name'],
        showTime: json['time'],
        day: json['day'],
        channel: json['channel']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'showTime': showTime,
      'day': day,
      'channel': channel
    };
  }
}
