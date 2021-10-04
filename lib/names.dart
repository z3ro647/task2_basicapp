import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Names extends StatefulWidget {
  const Names({Key? key}) : super(key: key);

  @override
  _NamesState createState() => _NamesState();
}

class _NamesState extends State<Names> {
  String name = "";
  TextEditingController _addNameController = TextEditingController();

  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Name List'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _addNameController,
                        decoration: InputDecoration(labelText: 'Enter Name'),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          child: Text("Add to Database"),
                          onPressed: () {
                            _addToDatabase(_addNameController.text);
                            _addNameController.text = "";
                          }),
                    )
                  ],
                ),
              ),
            ),
            //Divider(),
            Expanded(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Enter to Search....',
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blueAccent, width: 0.0),
                        )),
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (searchString == null || searchString.trim() == "")
                        ? FirebaseFirestore.instance
                            .collection("names")
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection("names")
                            .where("nameSearch", arrayContains: searchString)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          return new ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              return new ListTile(
                                title: new Text(document['name']),
                              );
                            }).toList(),
                          );
                      }
                    },
                  ),
                )
              ],
            )),
          ],
        ));
  }

  void _addToDatabase(String name) {
    List<String> splitList = name.split(" ");

    List<String> indexList = [];

    for (int i = 0; i < splitList.length; i++) {
      for (int y = 1; y < splitList[i].length + 1; y++) {
        indexList.add(splitList[i].substring(0, y).toLowerCase());
      }
    }

    print(indexList);

    FirebaseFirestore.instance
        .collection('names')
        .doc()
        .set({'name': name, 'nameSearch': indexList});
  }

  // void initiateSearch(String val) {
  //   setState(() {
  //     name = val.toLowerCase().trim();
  //   });
  // }
}
