import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task2_basicapp/color/customcolor.dart';
import 'package:task2_basicapp/database/sql_helper.dart';
import 'package:task2_basicapp/screen/dashboard.dart';
import 'package:task2_basicapp/screen/forgot.dart';
import 'package:task2_basicapp/screen/register.dart';
import 'package:task2_basicapp/screen/search.dart';
import 'package:task2_basicapp/service/userdataservice.dart';
import 'package:task2_basicapp/userinfoclass.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final _userDataService = UserDataService();

  void _checkUser(String mobile, String password) async {
    var data = _userDataService.getOneUser(mobile, password);
    data.then((value) {
      String tempMobile;
      String tempPassword;
      tempMobile = value.mobile;
      tempPassword = value.password;
      
    });
  }
  
  void loginUser2Firebase(mobile, password, [DocumentSnapshot? documentSnapshot]) async {
    //_users.get().then((value) => null)
   // Get.to(Dashboard());
   users.id;
  }

  static Stream<QuerySnapshot> readItems() {
    //CollectionReference notesItemCollection = FirebaseFirestore.instance.collection('users').doc().collection('name');
    CollectionReference notesItemCollection = FirebaseFirestore.instance.collection('users').doc().collection('name');
    return notesItemCollection.snapshots();
  }

  void all () async {
    users.snapshots();
  }

  void _try() async {
    _userDataService.getAllUser();
  }

  Future<void> _try1() async {
    var data = _userDataService.getUser1();
    data.then((value) {
      print("Name: "+value.name);
      print("Address: "+value.address);
      print("UserName: "+value.userName);
      print("Password: "+value.password);
      print("ID: "+value.sId);
    });
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
          Form(
            key: _formKey,
            child: Column(children: [
              CustomWidget(
                labeltext: 'Mobile',
                hinttext: 'Enter Mobile',
                icon: Icons.person,
                controller: mobile,
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomWidget(
                  labeltext: 'Password',
                  hinttext: 'Enter Password',
                  icon: Icons.lock,
                  controller: password)
            ]),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate())
                    // String mN = mobile.text.toString();
                    // String pW = password.text.toString();
                    // loginValidate(mobile.text.toString(), password.text.toString());
                    //_checkUser(mobile.text.toString(), password.text.toString());
                    loginUser2Firebase(mobile.text, password.text);
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  primary: colorGreen,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: SizedBox(
              height: 50,
              child: Builder(
                  builder: (context) => ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Forgot()));
                        },
                        child: Text(
                          'Forgot Password',
                        ),
                        style: ElevatedButton.styleFrom(primary: colorGreen),
                      )),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account yet?"),
              Builder(
                  builder: (context) => TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: colorGreen),
                      ))),
            ],
          ),

                      
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: SizedBox(
              height: 50,
              child: Builder(
                  builder: (context) => ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search()));
                        },
                        child: Text(
                          'Search',
                        ),
                        style: ElevatedButton.styleFrom(primary: colorGreen),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget(
      {Key? key,
      required this.labeltext,
      required this.hinttext,
      required this.icon,
      required this.controller})
      : super(key: key);

  final String labeltext;
  final String hinttext;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 2.0,
        shadowColor: Colors.blue,
        child: TextFormField(
            controller: controller,
            style: TextStyle(
                color: colorGreen, fontWeight: FontWeight.bold, fontSize: 20.0),
            autocorrect: false,
            decoration: InputDecoration(
              labelText: labeltext,
              labelStyle: TextStyle(
                  color: Colors.grey[400], fontWeight: FontWeight.bold),
              hintText: hinttext,
              prefixIcon: Icon(
                icon,
                color: colorGreen,
              ),
              hintStyle: TextStyle(
                color: colorGreen,
              ),
              filled: true,
              fillColor: Colors.white70,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (labeltext == 'Mobile') {
                if (value == null || value.isEmpty) {
                  return 'Mobile is Empty';
                }
                return null;
              } else if (labeltext == 'Password') {
                if (value == null || value.isEmpty) {
                  return 'Password is Empty';
                }
                return null;
              }
            }),
      ),
    );
  }
}

Future<void> loginValidate(mN, pW) async {
  List<Map<String, dynamic>> _users = [];
  final data = await SQLHelper.getUser(mN, pW);
  _users = data;
  int l = _users.length;
  if (mN.toString().isEmpty || pW.toString().isEmpty) {
    print('Mobile Number and Password is Empty');
  } else if (l == 1) {
    print('Mobile Number Found');
    print('Welcome $mN');
  } else {
    print('Mobile Number and Password does not matched');
  }
}
