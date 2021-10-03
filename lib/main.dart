import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task2_basicapp/brands.dart';
import 'package:task2_basicapp/names.dart';
import 'package:task2_basicapp/screen/dashboard.dart';
import 'package:task2_basicapp/screen/firebaseuserslist.dart';
import 'package:task2_basicapp/screen/login.dart';
import 'package:task2_basicapp/screen/search.dart';

void main() async {
  //runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    home: MyApp(),
    routes: {
      '/login': (BuildContext context) => Login(),
      '/dashboard': (BuildContext context) => Dashboard(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      //body: Login()
      //body: Search(),
      //body: FirebaseUsersList(),
      //body: Brands(),
      body: Names(),
    );
  }
}
