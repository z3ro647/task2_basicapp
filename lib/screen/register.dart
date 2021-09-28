import 'package:flutter/material.dart';
import 'package:task2_basicapp/color/customcolor.dart';
import 'package:task2_basicapp/database/sql_helper.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController mobile = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmpassword = TextEditingController();
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: TextField(
              controller: name,
              style: TextStyle(
                  color: colorGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.grey),
                  hintText: "Enter your name",
                  hintStyle: TextStyle(color: colorGreen),
                  prefixIcon: Icon(
                    Icons.person,
                    color: colorGreen,
                  ),
                  border: InputBorder.none),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: TextField(
              controller: email,
              style: TextStyle(
                  color: colorGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.grey),
                  hintText: "Enter your Email",
                  hintStyle: TextStyle(color: colorGreen),
                  prefixIcon: Icon(
                    Icons.email,
                    color: colorGreen,
                  ),
                  border: InputBorder.none),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: TextField(
              controller: mobile,
              style: TextStyle(
                  color: colorGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              decoration: InputDecoration(
                  labelText: "Mobile Number",
                  labelStyle: TextStyle(color: Colors.grey),
                  hintText: "Enter your Mobile Number",
                  hintStyle: TextStyle(color: colorGreen),
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: colorGreen,
                  ),
                  border: InputBorder.none),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: TextField(
              controller: password,
              style: TextStyle(
                  color: colorGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.grey),
                  hintText: "Enter your Password",
                  hintStyle: TextStyle(color: colorGreen),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: colorGreen,
                  ),
                  border: InputBorder.none),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: TextField(
              controller: confirmpassword,
              style: TextStyle(
                  color: colorGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              decoration: InputDecoration(
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(color: Colors.grey),
                  hintText: "Enter your Password",
                  hintStyle: TextStyle(color: colorGreen),
                  prefixIcon: Icon(
                    Icons.person,
                    color: colorGreen,
                  ),
                  border: InputBorder.none),
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
              child: ElevatedButton(
                onPressed: () {
                  String txtName = name.text.toString();
                  String txtEmail = email.text.toString();
                  String txtMobile = mobile.text.toString();
                  String txtPassword = password.text.toString();
                  String txtConfirmpassword = confirmpassword.text.toString();
                  formValidate(txtName, txtEmail, txtMobile, txtPassword,
                      txtConfirmpassword);
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

Future<void> formValidate(String txtName, String txtEmail, String txtMobile,
    String txtPassword, String txtConfirmpassword) async {
  if (txtName.isEmpty) {
    print('Name can not be empty');
  } else if(txtName.length < 5) {
    print('Name is Short');
  } else if (txtEmail.isEmpty) {
    print('Email can not be empty');
  } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(txtEmail) == false) {
    print('Enter Valid Email');
  } else if (txtMobile.isEmpty) {
    print('Mobile number can not be empty');
  } else if (txtMobile.length < 10) {
    print('Enter Valid Mobile Number');
  } else if (txtPassword.isEmpty || txtConfirmpassword.isEmpty) {
    print('Password and confirm password can not be empty');
  } else if (!txtPassword.endsWith(txtConfirmpassword)) {
    print('Enter same password in password and confirm password');
  } else {
    checkMobile(txtName, txtEmail, txtMobile, txtPassword, txtConfirmpassword);
  }
}

Future<void> checkMobile(String txtName, String txtEmail, String txtMobile, String txtPassword, String txtConfirmpassword) async {
  List<Map<String, dynamic>> _users = [];
  // Check mobile number
  final data = await SQLHelper.searchMobile(txtMobile);
  _users = data;
  int l = _users.length;
  if(l == 1) {
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
  }
}