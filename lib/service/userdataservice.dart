import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task2_basicapp/data/userdatamodel.dart';

class UserDataService {
  Future<UserResponse> getUser() async {

    final uri = Uri.https(
        'userinfo-42d8.restdb.io', '/rest/userinfo');

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-apikey': 'e93fffd0f227cb5af0123c85006bce20db71d',
      },
    );

    print(response.body);
    return UserResponse.fromJson(jsonDecode(response.body)[0]);
  }

  searchUser(String userName, String password) async {
    final queryParameters = {
      'q': '{"UserName":"$userName","Password":"$password"}',
    };
    final uri = Uri.https(
      'userinfo-42d8.restdb.io', '/rest/userinfo', queryParameters
    );

    //print(uri);

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-apikey': 'e93fffd0f227cb5af0123c85006bce20db71d',
      },
    );

    print('Data is: ');
    print(response.body);
  }
}

class UserResponse1 {
  final String user;
  final String address;
  final String username;
  final String password;

  UserResponse1({required this.user, required this.address, required this.username, required this.password});

  factory UserResponse1.fromJson(Map<String, dynamic> json) {
    final user = json['Name'];



    final address = json['Address'];
    final username = json['UserName'];
    final password = json['Password'];
    return UserResponse1(user: user, address: address, username: username, password: password);
  }

  
}