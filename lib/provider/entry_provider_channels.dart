import 'package:flutter/cupertino.dart';
import 'package:tvshowsapp/models/channel.dart';
import 'package:tvshowsapp/services/firestore_channel_services.dart';

class EntryProviderForChannels with ChangeNotifier {
  final firestoreService = FireStoreServiceForChannels();

  String _id;
  String _name;
  String _img;

  // Getters
  String get id => _id;
  String get name => _name;
  String get img => _img;

  Stream<List<Channel>> get entries => firestoreService.getEntries();
}
