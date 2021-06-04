//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:animate_do/animate_do.dart';
import 'package:uuid/uuid.dart';
import 'package:tvshowsapp/models/channel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'dart:async';

class AddChannels extends StatefulWidget {
  @override
  _AddChannelsState createState() => _AddChannelsState();
}

class _AddChannelsState extends State<AddChannels> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final format = DateFormat("HH:mm");
  String fileName;
  String path;
  Map<String, String> paths;
  List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  FileType fileType = FileType.image;
  String _chosenValue;
  String id = 'adad';
  var uuid = Uuid();
  String name = 'dada';
  String showTime;
  String day;
  String channel;
  Map data;

  void _openFileExplorer() async {
    setState(() => isLoadingPath = true);
    try {
      if (isMultiPick) {
        path = null;
        paths = await FilePicker.getMultiFilePath(
            type: fileType != null ? fileType : FileType.any,
            allowedExtensions: extensions);
      } else {
        path = await FilePicker.getFilePath(
            type: fileType != null ? fileType : FileType.any,
            allowedExtensions: extensions);
        paths = null;
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      isLoadingPath = false;
      fileName = path != null
          ? path.split('/').last
          : paths != null
              ? paths.keys.toString()
              : '...';
    });
  }

  FlutterLocalNotificationsPlugin localNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iOSInstialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInstialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "Local Notification", "This is the description",
        importance: Importance.high);

    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);

    await localNotification.show(
        12346,
        "Channel Notification",
        "Channel has been added to the system.Thank you.",
        generalNotificationDetails);
  }

  String firestoreCollectionName = "channels";
  Channel channels;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('channels');

  Future<void> addUser() {
    _showMyDialog();

    Timer(Duration(seconds: 5), () {
      _showNotification();
    });

    // Call the user's CollectionReference to add a new user
    // return users
    //     .add({
    //       'channel_id': id, // John Doe
    //       'name': name, // Stokes and Sons
    //       'img': '5b6p5Y+344GX44G+44GX44Gf77yB44GK44KB44Gn44Go44GG77yB' // 42
    //     })
    //     .then((value) => print("User Added"))
    //     .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    YYDialog.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Image.asset("assets/grd.jpg", fit: BoxFit.cover),
        title: Text(
          "Add new Channel",
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: Colors.grey[900], letterSpacing: .5, fontSize: 16)),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/svg.jpg"), fit: BoxFit.cover),
        ),
        child: Column(children: <Widget>[
          ZoomIn(
            child: Padding(
                padding: const EdgeInsets.only(right: 45, top: 20, left: 30),
                child: Image.asset('assets/p4.png', width: 200)),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                margin:
                    const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, bottom: 10.0, left: 20),
                    ),

                    //tv show name
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Tv-Show ID',
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 5.0),
                            ),
                          ),
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (text) {
                            id = text;
                          },
                        ),
                      ),
                    ),

                    //tvshow id
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Tv-Show Name',
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 5.0),
                            ),
                          ),
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (text) {
                            name = text;
                          },
                        ),
                      ),
                    ),

                    //upload button
                    IconButton(
                      icon: const Icon(Icons.linked_camera_outlined),
                      tooltip: 'Increase volume by 10',
                      onPressed: () {
                        _openFileExplorer();
                      },
                      hoverColor: Colors.pinkAccent,
                      iconSize: 50,
                    ),

                    //Submit button
                    Container(
                      height: 50.0,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            print(_formKey);
                            //addToDB(id, name);
                            //_showMyDialog();
                            addUser();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "ADD SHOW",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //image description
                    new Builder(
                      builder: (BuildContext context) => isLoadingPath
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: const CircularProgressIndicator())
                          : path != null || paths != null
                              ? new Container(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  height:
                                      MediaQuery.of(context).size.height * 0.10,
                                  child: new Scrollbar(
                                    child: new ListView.separated(
                                      itemCount:
                                          paths != null && paths.isNotEmpty
                                              ? paths.length
                                              : 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final bool isMultiPath =
                                            paths != null && paths.isNotEmpty;
                                        final int fileNo = index + 1;
                                        final String name = 'File $fileNo : ' +
                                            (isMultiPath
                                                ? paths.keys.toList()[index]
                                                : fileName ?? '...');
                                        final filePath = isMultiPath
                                            ? paths.values
                                                .toList()[index]
                                                .toString()
                                            : path;
                                        return new ListTile(
                                          title: new Text(
                                            name,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: new Text(filePath),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              new Divider(),
                                    ),
                                  ),
                                )
                              : new Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
