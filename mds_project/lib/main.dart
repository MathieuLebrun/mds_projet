import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_size/window_size.dart';
import 'views/accueilScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Vérifie la plateforme et effectue des actions spécifiques à chaque plateforme
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Définit le titre de la fenêtre
    setWindowTitle('Zhéros');
    // Définit la taille maximale et minimale de la fenêtre
    setWindowMaxSize(const Size(700, 900));
    setWindowMinSize(const Size(700, 900));
  }
  // Définit les orientations autorisées pour l'application
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zhéros',
      home: AccueilScreen(),
    );
  }
}
