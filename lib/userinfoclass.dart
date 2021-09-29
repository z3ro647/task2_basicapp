class UserInfoModel {
  String sId = "";
  String name = "";
  String address = "";
  String userName = "";
  String password = "";

  UserInfoModel(
      {required this.sId,
      required this.name,
      required this.address,
      required this.userName,
      required this.password});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['Name'];
    address = json['Address'];
    userName = json['UserName'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Name'] = this.name;
    data['Address'] = this.address;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    return data;
  }
}
