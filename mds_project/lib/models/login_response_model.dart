import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.username,
    required this.email,
    required this.id,
    required this.accesToken,
    required this.classe,
  });
  late final String username;
  late final String email;
  late final String id;
  late final String classe;
  late final String accesToken;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    classe = json['classe'];
    email = json['email'];
    id = json['_id'];
    accesToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['_id'] = id;
    _data['classe'] = classe;
    _data['accesToken'] = accesToken;
    return _data;
  }
}
