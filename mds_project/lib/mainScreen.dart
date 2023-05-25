import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:mds_project/services/api_service.dart';

import 'package:mds_project/services/persistancehandler.dart';
import 'package:mds_project/views/questionnaire.dart';

import 'login.dart';
import 'models/params_requets_model.dart';
import 'views/coursScreen.dart';
import 'views/draganddropScreen.dart';
import 'utilities/global.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key});

  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  late String token;
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
    token = (await PersistanceHandler().getTokenEDP())!;
    usernameController.text = (await PersistanceHandler().getUsername())!;
    emailController.text = (await PersistanceHandler().getEmail())!;
  }

  @override
  Widget build(BuildContext context) {
    var largeurEcran = MediaQuery.of(context).size.width;
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
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
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
                currentMatiere = "Français";
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => coursScreen()));
            },
            child: Container(
              color: currentcolorsMain,
              alignment: Alignment(0, -0),
              height: (hauteurEcran / fractionEcran),
              width: 250,
              child: monWidget(widthFactorImg, heightFactorImg, "Logo1etoile"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionnairePage(
                            questions: Math1,
                          )));
            },
            child: Container(
              height: (hauteurEcran / fractionEcran),
              color: currentcolorsMain,
              alignment: Alignment(-0.3, -0),
              child: monWidget(widthFactorImg, heightFactorImg, "Logo2etoile"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionnairePage(
                            questions: Math2,
                          )));
            },
            child: Container(
              height: (hauteurEcran / fractionEcran),
              color: currentcolorsMain,
              alignment: Alignment(-0.5, -0),
              child: monWidget(widthFactorImg, heightFactorImg, "Logo3etoile"),
            ),
          ),
          Container(
            color: currentcolorsMain,
            height: (hauteurEcran / fractionEcran),
            width: 250,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: 77,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionnairePage(
                                    questions: Math2,
                                  )));
                    },
                    child: Container(
                      child: monWidget(1.0, heightFactorImg, "LogoBoss1etoile"),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      //  child: monWidgetGIF(1.0, 4.0, "gifdanseshelou"),
                      ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            color: currentcolorsMain,
            alignment: Alignment(0, -0),
            height: (hauteurEcran / fractionEcran),
            width: 250,
            child: monWidget(widthFactorImg, heightFactorImg, "Logo1etoile"),
          ),
          Container(
            height: (hauteurEcran / fractionEcran),
            color: currentcolorsMain,
            alignment: Alignment(0.3, -0),
            child: monWidget(widthFactorImg, heightFactorImg, "Logo2etoile"),
          ),
          Container(
            height: (hauteurEcran / fractionEcran),
            color: currentcolorsMain,
            alignment: Alignment(0.5, -0),
            child: monWidget(widthFactorImg, heightFactorImg, "Logo3etoile"),
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
                    child: monWidget(1.0, heightFactorImg, "LogoBoss2etoile"),
                  ),
                ),
                SizedBox(
                  width: 77,
                ),
              ],
            ),
          ),
          Container(
            color: currentcolorsMain,
            alignment: Alignment(0, -0),
            height: (hauteurEcran / fractionEcran),
            width: 250,
            child: monWidget(widthFactorImg, heightFactorImg, "Logo1etoile"),
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => draganddropScreen()));
          }
          break;
        case 3:
          {
            currentcolors = const Color(0xFF383838);
            currentcolorsMain = const Color(0xFF848484);
            PersistanceHandler().clearPersistentData();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
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

  Widget monWidget(widthFactor, heightFactor, pathimg) {
    return FractionallySizedBox(
      widthFactor: widthFactor * 1.35,
      heightFactor: heightFactor * 1.35,
      child: Image(
        image: AssetImage("assets/images/" + pathimg + ".png"),
      ),
    );
  }

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
                  Text(
                    'Modifications de vos paramètres',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  Text(
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
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        //  await _ModifParams();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Enregistrer',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        var response = await _delUser();
                        if (response) {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
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

  Widget monWidgetGIF(widthFactor, heightFactor, pathimg) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: Container(
        alignment: Alignment(0, -1),
        child: Image(
          image: AssetImage("assets/" + pathimg + ".gif"),
        ),
      ),
    );
  }
/*
  Future<void> _ModifParams() async {
    var usernames = await PersistanceHandler().getUsername();
    var email = await PersistanceHandler().getEmail();

    ParamsModel model = ParamsModel(
      username: usernameController.text,
      email: emailController.text,
    );

    var response = await APIService().updateUserParams(usernames!, model);

    return null;
  }*/

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

  Widget monWidgetGIF2(widthFactor, heightFactor, pathimg) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment(0, -1),
          child: Image(
            image: AssetImage("assets/" + pathimg + ".gif"),
          ),
        ),
      ),
    );
  }
}
