import 'package:cloud_firestore/cloud_firestore.dart';

class Channel {
  String channel_id;
  String name;
  String img;

  Channel({this.channel_id, this.name, this.img});

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
        channel_id: json['channel_id'], name: json['name'], img: json['img']);
  }

  Map<String, dynamic> toMap() {
    return {
      'channel_id': channel_id,
      'name': name,
      'img': img,
    };
  }
}
