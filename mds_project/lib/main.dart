import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'guest.dart';

void main() async {
  // ? async parce que genre faut attendre que sa charge la connexion avec la base
  WidgetsFlutterBinding
      .ensureInitialized(); //  ? EN GROS  on lance une application donc un main qui a pour context une premier vue genre un layout
  // await Firebase.initializeApp();    // !  la faut que je rajoute les dependencies pour relier a la base fire base https://console.firebase.google.com/project/mydigitalproject/overview
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home:
          GuestScreen(), //   ? Du coup en vue principal on lui dit d'aller au gestionnaire de view
    );
  }
}
