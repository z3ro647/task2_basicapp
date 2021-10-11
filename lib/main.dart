import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task2_basicapp/autologin.dart';
import 'package:task2_basicapp/green_page.dart';
import 'package:task2_basicapp/names.dart';
import 'package:task2_basicapp/pushnotification.dart';
import 'package:task2_basicapp/red_page.dart';
import 'package:task2_basicapp/screen/firebaseuserslist.dart';
import 'package:task2_basicapp/screen/pushnotification.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  //runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(GetMaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "red": (_) => RedPage(),
        "green": (_) => GreenPage(),
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: FirebaseUsersList(),
      //body: Names(),
      //body: AutoLogin(),
      body: PushNotification(),
    );
  }
}
