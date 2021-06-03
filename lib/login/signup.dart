import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tvshowsapp/screens/trending_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tvshowsapp/login/add_signup_details.dart';
import 'package:tvshowsapp/screens/admin_home.dart';
import 'package:tvshowsapp/main.dart';
import 'package:tvshowsapp/login/login.dart';




class SignUp extends StatefulWidget {
  static String route = "SignUp";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = new TextEditingController();

  File _image;
  String imgUrl;


  String _contact, _email, _password;

  String get errormessage => null;



  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        //Navigator.pushReplacementNamed(context, '/');
        //Navigator.pushNamed(context, Start.route);
    }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser.updateProfile(displayName: _email);
          // await Navigator.pushReplacementNamed(context,"/") ;

        }
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }

    if (_formKey.currentState.validate()) {
      //dynamic result = await _auth.signInWithEmailAndPassword(email: _email, password: _password);

      var firebaseUser = await FirebaseAuth.instance.currentUser;
      var task = FirebaseStorage.instance.ref().child(_image.path).putFile(_image);
      imgUrl = await (await task).ref.getDownloadURL();

      if(firebaseUser.uid == "kXkGA42heyRSBFmtMvEJqMkVAgm2"){ // tried to find admin with its uid
        return AlertDialog(
          title: Text('ERROR'),
          content: Text(errormessage),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(this.context).pop();
                },
                child: Text('OK'))
          ],
        );
      }
      else{
        Navigator.push(this.context, MaterialPageRoute(builder: (context) => ListViewPage()));
      }
    }
    userSetup(_email,_contact,imgUrl);

  }

  showError(String errormessage) {
    showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToLogin() async {
    Navigator.push(this.context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(_image);
      uploadTask.then((res) {
        res.ref.getDownloadURL();
      });

      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
        backgroundColor: Colors.transparent,

        body: SingleChildScrollView(
          child: Container(
            height: 872,
            decoration: BoxDecoration(

                /*gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purple,Colors.white,Colors.blueAccent,])*/
                image: DecorationImage(
                image: AssetImage("assets/grd.jpg"), fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
                SizedBox(height: 70),
                RichText(
                    text: TextSpan(
                        text: 'SIGNUP TO ',
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'CeyFlix',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFF50057)))
                        ])),
                SizedBox(
                  height: 40.0,
                ),
                Padding(padding: EdgeInsets.fromLTRB(120, 0, 90, 0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      //Padding(padding: EdgeInsets.only(top: 60.0),),
                      child: CircleAvatar(
                        radius: 90,
                        backgroundColor: Color(0xff476cfb),

                        child: ClipOval(
                          child: new SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_image!=null)?Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://www.kindpng.com/picc/m/381-3817314_transparent-groups-of-people-png-user-icon-round.png",
                              fit: BoxFit.fill,
                            ),

                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.camera,
                          size: 30.0,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextFormField(
                              keyboardType: TextInputType.phone,
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Contact Number';
                                else if (input.length != 10  ) return 'Provide 10 digits';
                              },
                              decoration: InputDecoration(
                                labelText: 'Contact Number',
                                prefixIcon: Icon(Icons.person),
                              ),
                              onSaved: (input) => _contact = input),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) {
                                if (input.isEmpty || !input.contains('@')) return 'Enter a valid Email';
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email)),
                              onSaved: (input) => _email = input),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextFormField(
                              validator: (input) {
                                if (input.length < 6)
                                  return 'Provide Minimum 6 Character';
                              },
                              decoration: InputDecoration(

                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                              controller: _passwordController,
                              onSaved: (input) => _password = input),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextFormField(
                              validator: (input) {
                                if (input.length < 6)
                                  return 'Provide Minimum 6 Character';
                                else if(input.isEmpty || input != _passwordController.text)
                                {
                                  return 'Invalid Password';
                                }
                                return null;
                              },

                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                              onSaved: (input) => _password = input),
                        ),
                        /*SizedBox(height: 10),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed: (){
                            uploadPic(context);
                            signUp();
                            } ,
                          child: Text('SignUp',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          color: const Color(0xFFF50057),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),*/
                        Container(
                          height: 50.0,
                          margin: EdgeInsets.all(10),
                          child: RaisedButton(
                            onPressed: (){
                              uploadPic(context);
                              signUp();
                            } ,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF50057),

                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 250.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "SIGNUP",
                                  textAlign: TextAlign.center,
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          child: Text('Already have an account? Login'),
                          onTap: navigateToLogin,
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}