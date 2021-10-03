import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task2_basicapp/color/customcolor.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

TextEditingController search = TextEditingController();

class Search extends StatefulWidget {
  const Search({ Key? key }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  Future<void> readItems() async {
    List<DocumentSnapshot> document = (await users.doc().collection("users").where("email", isEqualTo: "z3ro647@gmail.com").get()).docs;
    print(document);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Image Container
          Container(
            height: 220.0,
            child: Image.asset('assets/images/reward.jpg'),
          ),
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: TextField(
              controller: search,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              onPressed: () {
                readItems();
              },
              child: Text('Search'),
            ),
          ),
        ],
      ),
    );
  }
}
