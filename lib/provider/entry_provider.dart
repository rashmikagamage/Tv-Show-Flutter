import 'package:flutter/cupertino.dart';
import 'package:tvshowsapp/models/tvshow.dart';
import 'package:tvshowsapp/services/firestore_services.dart';

class EntryProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _id;
  String _name;
  String _showTime;
  String _day;
  String _channel;
  String _rating;
  String _ratedUsersCount;

  // Getters
  String get id => _id;
  String get name => _name;
  String get showTime => _showTime;
  String get day => _day;
  String get channel => _channel;
  String get rating => _rating;
  String get ratedUsersCount=> _ratedUsersCount;
  Stream<List<Entry>> get entries => firestoreService.getEntries();

  // Setters

  set changeId(String id) {
    _id = id;
  }

  set changeName(String name) {
    _name = name;
    notifyListeners();
  }

  set changeShowTime(String showTime) {
    _showTime = showTime;
    notifyListeners();
  }

  set changeDay(String day) {
    _day = day;
    notifyListeners();
  }

  set changeChannel(String channel) {
    _channel = channel;
    notifyListeners();
  }

  set changeRating(String rating) {
    _rating = rating;
    notifyListeners();
  }

  set changeratedUsersCount(String ratedUsersCount) {
    _ratedUsersCount = ratedUsersCount;
    notifyListeners();
  }

  // Functions
  loadAll(Entry entry) {
    if (entry != null) {
      _id = entry.id;
      _name = entry.name;
      _showTime = entry.showTime;
      _day = entry.day;
      _channel = entry.channel;
      _rating = entry.rating;
      _ratedUsersCount = entry.ratedUsersCount;
    } else {
      _id = null;
      _name = null;
      _showTime = null;
      _day = null;
      _channel = null;
      _rating = null;
      _ratedUsersCount = entry.ratedUsersCount;
    }
  }

  // Update
  updateEntry() {
    print(_id);
    var entry = Entry(
        id: _id,
        name: _name,
        channel: _channel,
        day: _day,
        showTime: _showTime,
        rating: _rating,
        ratedUsersCount: _ratedUsersCount
        );
    firestoreService.setEntry(entry);
  }

  // Delete
  removeEntry(String entryId) {
    firestoreService.removeEntry(entryId);
  }
}
