import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2_basicapp/screen/pushnotification.dart';
import 'package:task2_basicapp/screen/settings.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
  final uid = FirebaseAuth.instance.currentUser!.uid;

  String fname = "";
  String lname = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printName();
  }

  Future<void> printName() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance.collection('usernames').doc(uid).get();
    setState(() {
      fname = variable.get('fname');
      lname = variable.get('lname');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          Text(
            'Welcome',
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            fname+' '+lname,
            style: TextStyle(fontSize: 25.0, color: Colors.white),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Select An Option',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Main Menu',
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
          SizedBox(
            height: 20.0,
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: <Widget>[
              Material(
                color: Colors.grey[800],
                child: InkWell(
                  onTap: () {
                    print('object');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        color: Colors.redAccent[400],
                        size: 80.0,
                      ),
                      Text(
                        "To-Do list",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Material(
                color: Colors.grey[800],
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        color: Colors.blue[600],
                        size: 80.0,
                      ),
                      Text(
                        "Your notes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Material(
                color: Colors.grey[800],
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.today_outlined,
                        color: Colors.purple[700],
                        size: 80.0,
                      ),
                      Text(
                        "Agenda",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Material(
                color: Colors.grey[800],
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      )
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.orange[300],
                        size: 80.0,
                      ),
                      Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
