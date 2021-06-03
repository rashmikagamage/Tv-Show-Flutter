import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tvshowsapp/login/signup.dart';
import 'package:tvshowsapp/screens/trending_list.dart';
import 'package:tvshowsapp/screens/admin_home.dart';

class Login extends StatefulWidget {
  static String route = "Login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);

        //Navigator.pushNamed(context, '/AdminHome');
        //Navigator.pushReplacementNamed(context, '/');
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ListViewPage()));

      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }

    if (_formKey.currentState.validate()) {
      //dynamic result = await _auth.signInWithEmailAndPassword(email: _email, password: _password);

      var firebaseUser = await FirebaseAuth.instance.currentUser;

      if(firebaseUser.uid == "kXkGA42heyRSBFmtMvEJqMkVAgm2"){ // tried to find admin with its uid
        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHome()));
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => ListViewPage()));
      }
    }

  }

  showError(String errormessage) {
    showDialog(
        context: context,
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

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.transparent,

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

              SizedBox(height: 60.0),
              Container(
                height: 200,
                child: Image(
                  image: AssetImage("assets/login.png"),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 30),
              RichText(
                  text: TextSpan(
                      text: 'LOGIN TO ',
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
              Container(

                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(20.0),
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
                        margin: const EdgeInsets.all(20.0),
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
                            onSaved: (input) => _password = input),
                      ),
                      /*SizedBox(height: 10),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                        onPressed: login,
                        child: Text('LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        color: const Color(0xFFF50057),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      )*/
                      Container(
                        height: 50.0,
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          onPressed: login,
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
                                "LOGIN",
                                textAlign: TextAlign.center,
                                style:
                                TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                child: Text('Create an Account?'),
                onTap: navigateToSignUp,
              )
            ],
          ),

        )
        )
    );
  }
}
