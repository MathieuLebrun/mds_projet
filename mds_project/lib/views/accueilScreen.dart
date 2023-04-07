import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 150, 0, 80),
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
              border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
            ),
            child: Text(
              "Lorem ipsum dolor sit amet, consecteturadipiscing elit, sed do eiusmod temporincididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquipex ea commodo consequat.",
              style: TextStyle(
                  color: Colors.black, fontSize: 20, fontFamily: 'Helvetica'),
            ),
          ),
          ElevatedButton(
            onPressed: null,
            child: const Text("S'inscrire"),
          ),
        ],
      ),
    );
  }
}
