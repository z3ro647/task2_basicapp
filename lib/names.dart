import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Names extends StatefulWidget {
  const Names({ Key? key }) : super(key: key);

  @override
  _NamesState createState() => _NamesState();
}

class _NamesState extends State<Names> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (val) => initiateSearch(val),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: name != "" && name != null ? FirebaseFirestore.instance.collection('names').where("nameSearch", arrayContains: name).snapshots() : FirebaseFirestore.instance.collection("names").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading....');
            default:
              return new ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return new ListTile(
                    title: new Text(document['name']),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }

  void initiateSearch(String val) {
    setState(() {
      name = val .toLowerCase().trim();
    });
  }
}