import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();

  CollectionReference usernames =
      FirebaseFirestore.instance.collection('usernames');

  final uid = FirebaseAuth.instance.currentUser!.uid;
  
  FirebaseStorage storage = FirebaseStorage.instance;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();

  String fname = "";
  String lname = "";

  void insertUsername() {
    usernames.doc(uid).set({"fname": fname, "lname": lname});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //printName();
  }

  Future<void> printName() async {
    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection('usernames').doc(uid).get();
    print("First Name: " + variable.get('fname'));
    print("Last Name: " + variable.get('lname'));
    print(variable.data());
  }

  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    PickedFile? pickedImage;
    try {
      pickedImage = await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'A bad guy',
              'description': 'Some description...'
            }));

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Settings Screen"),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    child: TextFormField(
                      controller: fnameController,
                      autofocus: false,
                      style: TextStyle(color: Colors.redAccent),
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        hintText: 'Enter First Name',
                        labelStyle:
                            TextStyle(fontSize: 20.0, color: Colors.white),
                        hintStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0)),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter First name';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    child: TextFormField(
                      controller: lnameController,
                      style: TextStyle(color: Colors.redAccent),
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Enter Last Name',
                        labelStyle:
                            TextStyle(fontSize: 20.0, color: Colors.white),
                        hintStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0)),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Last Name';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    child: MaterialButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          fname = fnameController.text;
                          lname = lnameController.text;
                          insertUsername();
                        }
                      },
                      height: 70.0,
                      minWidth: double.infinity,
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Change Name',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    child: MaterialButton(
                      onPressed: () {
                        _upload('gallery');
                      },
                      height: 70.0,
                      minWidth: double.infinity,
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Change Image',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
