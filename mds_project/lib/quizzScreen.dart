import 'package:flutter/material.dart';

class quizzScreen extends StatefulWidget {
  final Function(int) onChangedStep;
  const quizzScreen({Key? key, required this.onChangedStep}) : super(key: key);

  @override
  _quizzScreenState createState() => _quizzScreenState();
}

class _quizzScreenState extends State<quizzScreen> {
  @override
  void initState() {
    // ? La méthode init state c'est une méthode lancer une seule fois quand on arriver dans une view donc au lancement dans l'app on va dans le gestionnaire puis cette methode utiliser qu'une fois
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        SizedBox(height: 20),
        Text("data"),
      ]),
    ));
  }
}
