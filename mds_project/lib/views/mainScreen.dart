import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mds_project/services/api_service.dart';

import 'package:mds_project/services/persistancehandler.dart';
import 'package:mds_project/views/questionnaire.dart';

import './login.dart';
import 'coursScreen.dart';
import 'coursScreenDesktop.dart';
import 'statistiqueScreen.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  mainScreenState createState() => mainScreenState();
}

class mainScreenState extends State<mainScreen> {
  String currentMatiere = "Math";
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  int selectedIndex = 0;
  Color currentcolors = const Color(0xFFDD45F2);
  Color currentcolorsMain = const Color(0xFFDD45F2);
  @override
  void initState() {
    // ? La méthode init state c'est une méthode lancer une seule fois quand on arriver dans une view donc au lancement dans l'app on va dans le gestionnaire puis cette methode utiliser qu'une fois
    super.initState();
    init();
  }

  init() async {
    usernameController.text = (await PersistanceHandler().getUsername())!;
    emailController.text = (await PersistanceHandler().getEmail())!;
  }

  @override
  Widget build(BuildContext context) {
    var hauteurEcran = MediaQuery.of(context).size.height;
    var fractionEcran = 8;
    var widthFactorImg = 0.22;
    var heightFactorImg = 0.8;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text(currentMatiere)),
        backgroundColor: currentcolors,
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Math"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Français"),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text("Anglais"),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              setState(() {
                currentMatiere = "Math";
              });
            } else if (value == 1) {
              setState(() {
                currentMatiere = "Francais";
              });
            } else if (value == 2) {
              setState(() {
                currentMatiere = "Anglais";
              });
            }
          }),
        ],
      ),
      backgroundColor: currentcolorsMain,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          InkWell(
            onTap: () {
              if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CoursScreenDesktop()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const coursScreen()));
              }
            },
            child: Container(
              color: currentcolorsMain,
              alignment: const Alignment(0, -0),
              height: (hauteurEcran / fractionEcran),
              width: 250,
              child: monWidget(widthFactorImg, heightFactorImg, "courslogo"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Questionnaire(
                            question: '${currentMatiere}1',
                            index: 0,
                            matiere: currentMatiere,
                          )));
            },
            child: Container(
              height: (hauteurEcran / fractionEcran),
              color: currentcolorsMain,
              alignment: const Alignment(-0.3, -0),
              child: monWidget(widthFactorImg, heightFactorImg, "Logo1etoile"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Questionnaire(
                            question: '${currentMatiere}2',
                            index: 1,
                            matiere: currentMatiere,
                          )));
            },
            child: Container(
              height: (hauteurEcran / fractionEcran),
              color: currentcolorsMain,
              alignment: const Alignment(-0.5, -0),
              child: monWidget(widthFactorImg, heightFactorImg, "Logo2etoile"),
            ),
          ),
          Container(
            color: currentcolorsMain,
            height: (hauteurEcran / fractionEcran),
            width: 250,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(
                  width: 77,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Questionnaire(
                                    question: '${currentMatiere}3',
                                    index: 2,
                                    matiere: currentMatiere,
                                  )));
                    },
                    child: Container(
                      child: monWidget(1.0, heightFactorImg, "Logo3etoile"),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      //  child: monWidgetGIF(1.0, 4.0, "gifdanseshelou"),
                      ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            color: currentcolorsMain,
            alignment: const Alignment(0, -0),
            height: (hauteurEcran / fractionEcran),
            width: 250,
            child:
                monWidget(widthFactorImg, heightFactorImg, "LogoBoss1etoile"),
          ),
          Container(
            height: (hauteurEcran / fractionEcran),
            color: currentcolorsMain,
            alignment: const Alignment(0.3, -0),
            child: monWidget(widthFactorImg, heightFactorImg, "courslogo"),
          ),
          Container(
            height: (hauteurEcran / fractionEcran),
            color: currentcolorsMain,
            alignment: const Alignment(0.5, -0),
            child: monWidget(widthFactorImg, heightFactorImg, "Logo1etoile"),
          ),
          Container(
            color: currentcolorsMain,
            height: (hauteurEcran / fractionEcran),
            width: 250,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                      //   child: monWidgetGIF2(1.0, 4.0, "gifdanseshelou2"),
                      ),
                ),
                Expanded(
                  child: Container(
                    child: monWidget(1.0, heightFactorImg, "Logo2etoile"),
                  ),
                ),
                const SizedBox(
                  width: 77,
                ),
              ],
            ),
          ),
          Container(
            color: currentcolorsMain,
            alignment: const Alignment(0, -0),
            height: (hauteurEcran / fractionEcran),
            width: 250,
            child: monWidget(widthFactorImg, heightFactorImg, "Logo3etoile"),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFFDD45F2),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
            backgroundColor: Color(0xFFFFFF75),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Statistique',
            backgroundColor: Color(0xFFc93626),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'logout',
            backgroundColor: Color(0xFF383838),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

// Cette méthode est appelée lorsque l'un des éléments de la barre de navigation inférieure est sélectionné. Elle met à jour l'index sélectionné et effectue différentes actions en fonction de l'index sélectionné.
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      switch (selectedIndex) {
        case 0:
          {
            currentcolors = const Color(0xFFDD45F2);
            currentcolorsMain = const Color(0xFFff48fc);
          }
          break;
        case 1:
          {
            currentcolors = const Color(0xFFFFFF75);
            currentcolorsMain = const Color(0xFFffffb9);
            //Inserer le logout

            showDialogFunction(context);
          }
          break;

        case 2:
          {
            currentcolors = const Color(0xFFc93626);
            currentcolorsMain = const Color.fromARGB(255, 252, 68, 28);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StatistiqueScreen()));
          }
          break;
        case 3:
          {
            currentcolors = const Color(0xFF383838);
            currentcolorsMain = const Color(0xFF848484);
            PersistanceHandler().clearPersistentData();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          }
          break;

        default:
          {
            //statements;
          }
          break;
      }
    });
  }

  //Cette méthode renvoie un widget "FractionallySizedBox" contenant un widget "Image". Elle est utilisée pour afficher une image avec un facteur de largeur et de hauteur spécifique.
  Widget monWidget(widthFactor, heightFactor, pathimg) {
    return FractionallySizedBox(
      widthFactor: widthFactor * 1.35,
      heightFactor: heightFactor * 1.35,
      child: Image(
        image: AssetImage("assets/images/" + pathimg + ".png"),
      ),
    );
  }

//Cette méthode affiche une boîte de dialogue lorsqu'elle est appelée. Elle affiche l'e-mail et le nom d'utilisateur, et fournit un bouton pour supprimer le compte utilisateur.
  void showDialogFunction(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            content: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Suppresion du compte',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  const Text(
                    'Username',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        var response = await _delUser();
                        if (response) {
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          }
                        } else {}
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Supprimer votre compte',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// Cette méthode envoie une requête à "APIService" pour supprimer le compte utilisateur. Si la requête est réussie (code de statut 200), elle efface les données persistantes et renvoie "true".
  Future<bool> _delUser() async {
    var usernames = await PersistanceHandler().getUsername();

    var response = await APIService().delUser(usernames!);
    if (response.statusCode == 200) {
      PersistanceHandler().clearPersistentData();
      return true;
    } else {
      return false;
    }
  }
}
