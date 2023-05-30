import 'package:flutter/material.dart';
import 'package:mds_project/views/inscription.dart';

import 'login.dart';

class AccueilScreen extends StatefulWidget {
  // ? la je suis definie une methode obligatoire le changestep qui a un int "index" puis les deux string mdp login
  AccueilScreen({
    Key? key,
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
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black, width: 2)),
              ),
              child: Text(
                "Devenez un Z'héros de la révision et rejoignez notre communauté de super-élèves ! Inscrivez-vous dès maintenant pour accéder à notre programme de révision ludique et efficace.",
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
                          builder: (context) => InscriptionScreen()));
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
                child: const Center(
                  child: Text("S'inscrire",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Helvetica')),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
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
              child: const Center(
                child: Text("Se connecter",
                    style: TextStyle(
                        color: Colors.black,
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
