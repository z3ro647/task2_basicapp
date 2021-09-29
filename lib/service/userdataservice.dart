import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task2_basicapp/data/userdatamodel.dart';
import 'package:task2_basicapp/userinfoclass.dart';

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

  Future<UserInfoModel> getUser1() async {
    final queryParameters = {
      'q': '{"UserName":"vivek","Password":"123456"}',
    };
    final uri = Uri.https(
        'userinfo-42d8.restdb.io', '/rest/userinfo', queryParameters);

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-apikey': 'e93fffd0f227cb5af0123c85006bce20db71d',
      },
    );
    return UserInfoModel.fromJson(jsonDecode(response.body)[0]);
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
