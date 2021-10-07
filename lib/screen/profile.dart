import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

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

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has benn sent');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has benn sent',
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                backgroundColor: Colors.redAccent),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ListView(
        children: [
          Center(
            child: ClipOval(
              child: Material(
                child: Image.asset(
                  'assets/images/reward.jpg',
                  fit: BoxFit.fitHeight,
                  height: 150,
                  width: 150,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              fname+' '+lname,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              'User ID: $uid',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: Text(
              'Email: $email',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
          // Row(
          //   children: [
          //     Text(
          //       'Email: $email',
          //       style: TextStyle(
          //         fontSize: 18.0,
          //         color: Colors.white
          //       ),
          //     ),
          //     user!.emailVerified
          //         ? Text(
          //             'verified',
          //             style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
          //           )
          //         : TextButton(
          //             onPressed: () => {
          //               verifyEmail()
          //             },
          //             child: Text('Verify Email')
          //           )
          //   ],
          // ),
          // Text(
          //   'Created: $creationTime',
          //   style: TextStyle(
          //     fontSize: 18.0,
          //     color: Colors.white
          //   ),
          // ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.facebook,
                color: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(Icons.adb, color: Colors.white)
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.grey[850],
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'About',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          Container(
            color: Colors.grey[850],
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
