import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';



class Start extends StatefulWidget {
  static String route = "Start";

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
        await _auth.signInWithCredential(credential);

        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "Login");
  }

  navigateToRegister() async {
    Navigator.pushReplacementNamed(context, "SignUp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/grd.jpg"), fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            SizedBox(height: 35.0),
            Container(
              height: 500,
              child: Image(
                image: AssetImage("assets/start.png"),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            RichText(
                text: TextSpan(
                    text: 'WELCOME TO ',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'CeyFlix',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFD50000)))
                    ])),
            SizedBox(height: 10.0),
            Text(
              'Your Largest Home Theater At Your Finger Tips',
              style: TextStyle(color: Colors.black),
            ),

            SizedBox(height: 50.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50.0,
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: navigateToLogin,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: const Color(0xFFD50000),
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
                Container(
                  height: 50.0,
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: navigateToRegister,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: const Color(0xFFD50000),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: 250.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "REGISTER",
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

          ],
        ),
      ),
    );
  }
}
