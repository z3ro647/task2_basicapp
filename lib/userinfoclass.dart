class UserInfoModel {
  String sId = "";
  String name = "";
  String address = "";
  String userName = "";
  String password = "";
  String mobile = "";
  String email = "";

  UserInfoModel(
      {required this.sId,
      required this.name,
      required this.address,
      required this.userName,
      required this.password,
      required this.mobile,
      required this.email});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['Name'];
    address = json['Address'];
    userName = json['UserName'];
    password = json['Password'];
    mobile = json['Mobile'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Name'] = this.name;
    data['Address'] = this.address;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['Mobile'] = this.mobile;
    data['Email'] = this.email;
    return data;
  }
}
