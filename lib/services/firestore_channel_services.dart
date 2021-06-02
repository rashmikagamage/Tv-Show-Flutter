import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tvshowsapp/models/channel.dart';

class FireStoreServiceForChannels {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get Entries
  Stream<List<Channel>> getEntries() {
    return _db.collection('channels').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Channel.fromJson(doc.data())).toList());
  }
}
