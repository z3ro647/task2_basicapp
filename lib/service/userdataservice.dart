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

    print('This is the Data');
    print(response.body);
    return UserResponse.fromJson(jsonDecode(response.body)[0]);
  }
}