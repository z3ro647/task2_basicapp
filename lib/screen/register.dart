import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task2_basicapp/color/customcolor.dart';
import 'package:task2_basicapp/database/sql_helper.dart';
import 'package:task2_basicapp/screen/login.dart';
import 'package:task2_basicapp/service/userdataservice.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  CollectionReference _userss =
      FirebaseFirestore.instance.collection('users');

  void registerUser2Firebase() async {
    await _userss.add({"name": name, "mobile": mobile, "email": email, "password": password});
    Get.to(Login());
  }
  
  final _userDataService = UserDataService();

  void registerUser(String name, String address, String username, String password, String mobile, String email) async {
    var data = _userDataService.insertUser(name, address, username, password, mobile, email);
    data.then((value) {
      String tempMobile;
      String tempPassword;
      tempMobile = value.mobile;
      tempPassword = value.password;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            height: 350.0,
            child: Image.asset('assets/images/reward.jpg'),
          ),
          Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: 10.0,
              ),
              CustomWidget(
                  labeltext: "Name",
                  hinttext: "Enter your name",
                  icon: Icons.person,
                  controller: name),
              SizedBox(
                height: 10.0,
              ),
              CustomWidget(
                  labeltext: "Email",
                  hinttext: "Enter your Email",
                  icon: Icons.email,
                  controller: email),
              SizedBox(
                height: 10.0,
              ),
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
                  controller: password),
              SizedBox(
                height: 10.0,
              ),
              CustomWidget(
                  labeltext: "Confirm Password",
                  hinttext: "Enter Confirm Password",
                  icon: Icons.lock,
                  controller: confirmpassword)
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
                    //checkMobile(name.text, email.text, mobile.text, password.text, confirmpassword.text);
                    //registerUser(name.text, mobile.text, password.text, username.text, email.text, address.text);
                    registerUser2Firebase();
                },
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  primary: colorGreen,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              Builder(
                  builder: (context) => TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: colorGreen),
                      ))),
            ],
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
              if (labeltext == 'Name') {
                if(value == null || value.isEmpty)
                return 'Name is Empty';
              } else if(labeltext == 'Email') {
                if(value == null || value.isEmpty || !value.contains('@'))
                  return 'Enter valid Email';
              } else if (labeltext == 'Mobile') {
                if (value == null || value.isEmpty) {
                  return 'Mobile is Empty';
                }
                return null;
              } else if (labeltext == 'Password') {
                if (value == null || value.isEmpty) {
                  return 'Password is Empty';
                }
              } else if (labeltext == 'Confirm Password') {
                if(value == null || value.isEmpty) {
                  return 'Confirm Password is Empty';
                }
                return null;
              }
            }),
      ),
    );
  }
}

Future<void> checkMobile(String txtName, String txtEmail, String txtMobile,
    String txtPassword, String txtConfirmpassword) async {
  List<Map<String, dynamic>> _users = [];
  // Check mobile number
  final data = await SQLHelper.searchMobile(txtMobile);
  _users = data;
  int l = _users.length;
  if (l == 1) {
    print('Mobile already exist!');
  } else {
    // Insert a new users to the database
    await SQLHelper.createItem(txtName, txtEmail, txtMobile, txtPassword);
    print('Account created');
    txtName = '';
    txtEmail = '';
    txtMobile = '';
    txtPassword = '';
    txtConfirmpassword = '';
    Get.to(Login());
  }
}
