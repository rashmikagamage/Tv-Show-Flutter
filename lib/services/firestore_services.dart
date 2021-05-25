import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tvshowsapp/models/tvshow.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get Entries
  Stream<List<Entry>> getEntries() {
    return _db.collection('tvshows').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Entry.fromJson(doc.data())).toList());
  }

  //Upsert
  Future<void> setEntry(Entry entry) {
    var options = SetOptions(merge: true);
    return _db.collection('tvshows').doc(entry.id).set(entry.toMap(), options);
  }

  //Delete
  Future<void> removeEntry(String id) async {
    _db.collection('tvshows').where("id", isEqualTo: id).get().then((snapshot) {
      snapshot.docs.first.reference.delete();
    });
  }

  void tvShowStream() async{
    await for( var snapshot in _db.collection('tvshows').snapshots()){
      for (var message in snapshot.docs){
        print(message.data());
      }
    }
  }
}
