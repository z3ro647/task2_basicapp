import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task2_basicapp/screen/login.dart';
import 'package:task2_basicapp/screen/usermain.dart';

Future<FirebaseApp> initializeFirebase({
  required BuildContext context,
}) async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();

  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => UserMain(),
      ),
    );
  }

  return firebaseApp;
}

class AutoLogin extends StatefulWidget {
  const AutoLogin({Key? key}) : super(key: key);

  @override
  _AutoLoginState createState() => _AutoLoginState();
}

class _AutoLoginState extends State<AutoLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initializeFirebase(context: context),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Text('Error initalizing Firebase');
          } else if(snapshot.connectionState == ConnectionState.done) {
            return Login();
          }
          return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.redAccent,
            ),
          );
        }
      ),
    );
  }
}
