class User {
  final String id;
  final String username;
  final String email;
  final bool isAdmin;
  final String accesToken;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.accesToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      isAdmin: json['isAdmin'] as bool,
      accesToken: json['accesToken'] as String,
    );
  }
}
