class LoginRequestModel {
  LoginRequestModel({
    required this.username,
    required this.password,
  });

  late final String username;
  late final String password;

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
