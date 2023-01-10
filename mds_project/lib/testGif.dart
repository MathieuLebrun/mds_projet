import 'package:flutter/material.dart';

class testGifScreen extends StatefulWidget {
  final Function(int) onChangedStep;
  const testGifScreen({Key? key, required this.onChangedStep})
      : super(key: key);

  @override
  _testGifScreenState createState() => _testGifScreenState();
}

class _testGifScreenState extends State<testGifScreen> {
  @override
  void initState() {
    // ? La méthode init state c'est une méthode lancer une seule fois quand on arriver dans une view donc au lancement dans l'app on va dans le gestionnaire puis cette methode utiliser qu'une fois
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage('assets/anime.gif'));
  }
}
