import 'package:flutter/material.dart';
import 'package:mds_project/inscription.dart';

import '../login.dart';

class AccueilScreen extends StatefulWidget {
  final Function(int)
      onChangedStep; // ? la je suis definie une methode obligatoire le changestep qui a un int "index" puis les deux string mdp login
  AccueilScreen({
    Key? key,
    required this.onChangedStep,
  }) : super(key: key);

  @override
  _AccueilScreenState createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xffffffff),
              Color(0xffffffff),
              Color(0xFFffffb9),
              Color(0xFfcc55ea)
            ],
            center: Alignment.topLeft,
            radius: 2.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 120, 0, 80),
              child: Text(
                "Z'heros",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Asdean'),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              padding: EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black, width: 2)),
              ),
              child: Text(
                "Lorem ipsum dolor sit amet, consecteturadipiscing elit, sed do eiusmod temporincididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquipex ea commodo consequat.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Helvetica',
                    height: 1.3),
              ),
            ),
            SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0xffffffff), Color(0xFfcc55ea)],
                  center: Alignment.topLeft,
                  radius: 7.5,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width - 80,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InscriptionScreen(
                                onChangedStep: (i, b, z) {},
                              )));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  // elevation: MaterialStateProperty.all(3),
                  shadowColor: Colors.transparent,
                ),
                child: Center(
                  child: const Text("S'inscrire",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Helvetica')),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen(
                              onChangedStep: (i, b, z) {},
                            )));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                // elevation: MaterialStateProperty.all(3),
                shadowColor: Colors.transparent,
              ),
              child: Center(
                child: const Text("Se connecter",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Helvetica')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}