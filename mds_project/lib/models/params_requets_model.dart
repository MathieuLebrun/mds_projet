class ParamsModel {
  late String? username;
  late String? email;

  ParamsModel({
    required this.username,
    required this.email,
  });

  ParamsModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['email'] = email;
    return data;
  }
}
