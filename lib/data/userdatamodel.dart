/*
[
 {"_id":"6152cd6f868101090000996b","Name":"Vivek Kumar Gurung","Address":"Pokhara","UserName":"vivek","Password":"123456"},
 {"_id":"6152cd83868101090000996f","Name":"Prabesh Rijal","Address":"Pokhara","UserName":"prabesh","Password":"123456"}
]
*/
class UserResponse {
  final String user;
  final String address;
  final String username;
  final String password;

  UserResponse({required this.user, required this.address, required this.username, required this.password});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final user = json['Name'];
    final address = json['Address'];
    final username = json['UserName'];
    final password = json['Password'];
    return UserResponse(user: user, address: address, username: username, password: password);
  }
}