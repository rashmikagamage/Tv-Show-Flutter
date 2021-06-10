import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUser {
  final String uid;
  final String name;
  final String photoUrl;
  CurrentUser({
    this.uid,
    this.name,
    this.photoUrl,
  });

  CurrentUser copyWith({
    String uid,
    String name,
    String photoUrl,
  }) {
    return CurrentUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'photoUrl': photoUrl,
    };
  }

  factory CurrentUser.fromDoc(DocumentSnapshot doc) {
    if (doc == null) return null;

    return CurrentUser(
      uid: doc.id,
      name: doc.data()['name'],
      photoUrl: doc.data()['photo_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentUser.fromJson(String source) =>
      CurrentUser.fromMap(json.decode(source));

  @override
  String toString() => 'CurrentUser(id: $uid, name: $name, photoUrl: $photoUrl)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CurrentUser &&
        o.uid == uid &&
        o.name == name &&
        o.photoUrl == photoUrl;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ photoUrl.hashCode;

  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CurrentUser(
      uid: map['uid'],
      name: map['name'],
      photoUrl: map['photoUrl'],
    );
  }
}