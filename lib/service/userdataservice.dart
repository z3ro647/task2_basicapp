import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task2_basicapp/data/userdatamodel.dart';
import 'package:task2_basicapp/userinfoclass.dart';

class UserDataService {
  Future<UserResponse> getAllUser() async {

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

  Future<UserInfoModel> getOneUser(mobile, password) async {
    final queryParameters = {
      'q': '{"UserName":"$mobile","Password":"$password"}',
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

  Future<UserInfoModel> getUser1() async {
    int id = 0;
    final queryParameters = {
      'q': id,
    };
    final uri = Uri.https(
        'userinfo-42d8.restdb.io', '/rest/userinfo', queryParameters);

    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-apikey': 'e93fffd0f227cb5af0123c85006bce20db71d',
      },
      body: {"UserName":"vivek"}
    );
    return UserInfoModel.fromJson(jsonDecode(response.body)[0]);
  }

  Future<UserInfoModel> insertUser(String name, String address, String username, String password, String mobile, String email) async {
    final queryParameters = {
      'q': '{"Name":"$name","Address":"$address","UserName":"$username","Mobile":"$mobile","Password":"$password","Email":"$email"}',
    };
    final uri = Uri.https(
        'userinfo-42d8.restdb.io', '/rest/userinfo', queryParameters);

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-apikey': 'e93fffd0f227cb5af0123c85006bce20db71d',
      },
    );
    return UserInfoModel.fromJson(jsonDecode(response.body)[0]);
  }
}
