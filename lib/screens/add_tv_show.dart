import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

class AddTvShows extends StatefulWidget {
  @override
  _AddTvShowsState createState() => _AddTvShowsState();
}

class _AddTvShowsState extends State<AddTvShows> {
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

  addToDB(String id, String name, String channel, String day, String time) {
    id = Uuid().toString();
    Map<String, dynamic> demo = {
      "id": id,
      "name": name,
      "channel": channel,
      "day": day,
      "time": time,
      "img": '5b6p5Y+344GX44G+44GX44Gf77yB44GK44KB44Gn44Go44GG77yB'
    };

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('tvshows');
    collectionReference.add(demo);

    Fluttertoast.showToast(
        msg: "Successfully Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blueGrey[800],
        textColor: Colors.black,
        fontSize: 16.0);
    _formKey.currentState.reset();
    day = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Image.asset("assets/grd.jpg", fit: BoxFit.cover),
        title: Text(
          "         Add new Tv-Show",
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.grey[900], letterSpacing: .5, fontSize: 16),
          ),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/svg.jpg"), fit: BoxFit.cover),
        ),
        child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 45, top: 20, left: 20),
              child: Image.asset('assets/cinema.png', width: 250)),
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

                    //show name
                    Padding(
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

                    //show time
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: DateTimeField(
                        decoration: InputDecoration(
                          hintText: 'Select Show Time',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );

                          return DateTimeField.convert(time);
                        },
                        onSaved: (text) {
                          showTime = text.toString();
                        },
                      ),
                    ),

                    //channel select
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 0.0, left: 4.0),
                          child: DropdownButton<String>(
                            value: channel,
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),

                            items: <String>[
                              'HBO',
                              'TV Network',
                              'ABC',
                              'Netflix'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text(
                              "Select Channel",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                channel = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: DropdownButton<String>(
                            value: day,
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),

                            items: <String>[
                              'Monday',
                              'Tuesday',
                              'Wednesday',
                              'Thursday',
                              'Friday',
                              'Saturday',
                              'Sunday'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text(
                              "Select Day",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                day = value;
                              });
                            },
                          ),
                        ),
                        //upload button
                        IconButton(
                          icon: const Icon(Icons.file_upload),
                          tooltip: 'Increase volume by 10',
                          onPressed: () {
                            _openFileExplorer();
                          },
                        ),
                      ],
                    ),

                    //submit button
                    Container(
                      height: 50.0,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            addToDB(id, name, channel, day, showTime);
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
                                      MediaQuery.of(context).size.height * 0.50,
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
}

class FirebaseApp {}
