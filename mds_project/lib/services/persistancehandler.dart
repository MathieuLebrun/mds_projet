import 'package:shared_preferences/shared_preferences.dart';
//Le code  utilise le package shared_preferences pour gérer la persistance des données.
// Ce package permet de stocker des données de manière persistante sur le périphérique de l'utilisateur.

class PersistanceHandler {
  Future<String> setTokenEDP(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("persistentTokenEDP", value);
    return value;
  }

  Future<String?> getTokenEDP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("persistentTokenEDP");
  }

  Future<String> setID(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ID", value);
    return value;
  }

  Future<String?> getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("ID");
  }

  Future<String> setUsername(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("User", value);
    return value;
  }

  Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("User");
  }

  Future<String> setEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", value);
    return value;
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email");
  }

  // Permets de vider le persistance handler a la déconnexion
  void clearPersistentData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
