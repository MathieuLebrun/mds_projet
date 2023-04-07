class RegisterRequestModel {
  RegisterRequestModel({
    this.username,
    this.password,
    this.email,
    this.classe,
  });
  late final String? username;
  late final String? password;
  late final String? email;
  late final String? classe;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    classe = json['classe'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['password'] = password;
    _data['email'] = email;
    _data['classe'] = classe;
    return _data;
  }
}
