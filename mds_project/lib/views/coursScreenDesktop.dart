import 'dart:async';

import 'package:flutter/material.dart';

import './mainScreen.Dart';

class CoursScreenDesktop extends StatefulWidget {
  const CoursScreenDesktop({super.key});

  @override
  CoursScreenDesktopState createState() => CoursScreenDesktopState();
}

class CoursScreenDesktopState extends State<CoursScreenDesktop> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(minutes: 3), () {
      setState(() {
        _showButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text(
              "Lorem ipsum dolor sit amet, consecteturadipiscing elit, sed do eiusmod temporincididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquipex ea commodo consequat.Lorem ipsum dolor sit amet, consecteturadipiscing elit, sed do eiusmod temporincididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquipex ea commodo consequat.Lorem ipsum dolor sit amet, consecteturadipiscing elit, sed do eiusmod temporincididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquipex ea commodo consequat.Lorem ipsum dolor sit amet, consecteturadipiscing elit, sed do eiusmod temporincididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquipex ea commodo consequat.",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Helvetica',
                  height: 1.3),
            ),
            if (_showButton)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const mainScreen())); // action à effectuer lors du clic sur le bouton
                },
                child: const Text("Retour a l'écran principal"),
              ),
          ],
        ),
      ),
    );
  }
}
