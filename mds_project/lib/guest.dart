import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mds_project/inscription.dart';

import 'login.dart';
import 'testGif.dart';

class GuestScreen extends StatefulWidget {
  GuestScreen({Key? key}) : super(key: key);

  @override
  _GuestScreenState createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  //  ? Donc pareil ma classe gestionnaire elle a des parametres
  final List<Widget> _widget = []; // ? Ajout des liste des differentes views
  int _indexSelected =
      0; // ? Initialisation de la vue on va trier les differents ecran avec un index pour juste passer de l'écran 2 au 3
  final String _login = ''; // ? login mdp sa sera juste pour verif sur la base
  final String _motdepasse = ""; // ?
  @override
  void initState() {
    // ? La méthode init state c'est une méthode lancer une seule fois quand on arriver dans une view donc au lancement dans l'app on va dans le gestionnaire puis cette methode utiliser qu'une fois
    super.initState();
    _widget.addAll([
      // ? on ajoute donc a l'attribut de list tableau de vue vide l'écran login
      LoginScreen(
          onChangedStep: (index, value, value1) => setState(() {
                // ? avec sa méthode set state qui permets du coup de remodifier index
                _indexSelected =
                    index; //? cette méthode sera utiliser des que je serai depuis l'écran login pour pouvoir aller sur un autre ecran donc je recupererai 2 attribut un mdp un login et un index pour savoir la page a afficher

                if (value != null) {
                  // ? la normalement je verifie que les valeurs recupérer depuis login screen
                  // si la valeur des champs et differents de null test authentification de l'utilisateur
                  print(value);
                  print(value1);
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: value, password: value1);
                }
              })),
      testGifScreen(
          onChangedStep: (index) => setState(() => _indexSelected = index)),
      InscriptionScreen(
          onChangedStep: (index, value, value1) => setState(() {
                // ? avec sa méthode set state qui permets du coup de remodifier index
                _indexSelected =
                    index; //? cette méthode sera utiliser des que je serai depuis l'écran login pour pouvoir aller sur un autre ecran donc je recupererai 2 attribut un mdp un login et un index pour savoir la page a afficher
                print(value);
                print(value1);
                if (value != null) {
                  // ? la normalement je verifie que les valeurs recupérer depuis login screen
                  // si la valeur des champs et differents de null test authentification de l'utilisateur
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: value, password: value1);
                  /*
                  userService
                      .auth(UserModel(
                        login: value,
                        motdepasse: value1,
                      ))
                      .then((value) => print(value.toJson())); */
                }
              })),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //  ? l'écran gestionnaire renvoie en permanence la valeur de indexSelected dans un conteneur fesant la taille de l'écran
    return Container(
      child: _widget.elementAt(_indexSelected),
    );
  }
}
