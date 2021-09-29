import 'package:flutter/material.dart';
import 'package:task2_basicapp/color/customcolor.dart';

class Forgot extends StatefulWidget {
  const Forgot({ Key? key }) : super(key: key);

  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final _formKey = GlobalKey<FormState>();
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
          Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: 10.0,
              ),
              // CustomWidget(
              //     labeltext: "Name",
              //     hinttext: "Enter your name",
              //     icon: Icons.person,
              //     controller: name),
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
                  if (_formKey.currentState!.validate()) {

                  }
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