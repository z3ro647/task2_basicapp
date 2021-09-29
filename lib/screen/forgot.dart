import 'package:flutter/material.dart';
import 'package:task2_basicapp/color/customcolor.dart';
import 'package:task2_basicapp/screen/reset.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();

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
            height: 200.0,
            child: Image.asset('assets/images/reward.jpg'),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
              child: Text(
            'Enter your Email and Mobile number for password reset.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          )),
          Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: 10.0,
              ),
              CustomWidget(
                  labeltext: "Email",
                  hinttext: "Enter your email",
                  icon: Icons.person,
                  controller: email),
              SizedBox(
                height: 10.0,
              ),
              CustomWidget(
                  labeltext: "Mobile",
                  hinttext: "Enter your mobile",
                  icon: Icons.phone_android,
                  controller: mobile)
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
              child: Builder(
                  builder: (context) => ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Reset()));
                        },
                        child: Text(
                          'Reset',
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
                if (value == null || value.isEmpty) return 'Name is Empty';
              } else if (labeltext == 'Email') {
                if (value == null || value.isEmpty || !value.contains('@'))
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
                if (value == null || value.isEmpty) {
                  return 'Confirm Password is Empty';
                }
                return null;
              }
            }),
      ),
    );
  }
}
