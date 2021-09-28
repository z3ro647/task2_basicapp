import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task2_basicapp/data/userdatamodel.dart';

class UserDataService {
  Future<UserResponse> getUser(String username, String password) async {

    //https://userinfo-42d8.restdb.io/rest/userinfo?d=vivek
    //https://userinfo-42d8.restdb.io/rest/userinfo?q={"UserName":"vivek"}
    //https://userinfo-42d8.restdb.io/rest/userinfo?q={%22UserName%22:%22vivek%22}
    // final queryParameters = {
    //   'q': username,
    // };

    // final uri = Uri.https(
    //   'userinfo-42d8.restdb.io', '/rest/userinfo', queryParameters
    // );

    // print('This is Uri: $uri');
    // final response = await http.get(uri);
    // print(response.body);
    // final json = jsonDecode(response.body);
    // return UserResponse.fromJson(json)
      // todo - fix baseUrl
  var url = '{{baseURL}}/api/auth/login';
  var body = json.encode({
    'UserName': username,
  });

  print('Body: $body');

  var response = await http.post(
    Uri.parse('https://userinfo-42d8.restdb.io/rest/userinfo'),
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: body,
  );
  return json.decode(response.body);
  }
}