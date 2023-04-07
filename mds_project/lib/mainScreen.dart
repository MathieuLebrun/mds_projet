import 'package:flutter/material.dart';

import 'package:mds_project/services/persistancehandler.dart';
import 'package:mds_project/views/questionnaire.dart';

import 'views/coursScreen.dart';
import 'views/draganddropScreen.dart';

class mainScreen extends StatefulWidget {
  final Function(int) onChangedStep;
  const mainScreen({Key? key, required this.onChangedStep}) : super(key: key);

  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  late String token;
  String currentMatiere = "Math";
  int selectedIndex = 0;
  Color currentcolors = const Color(0xFFDD45F2);

  @override
  void initState() {
    // ? La méthode init state c'est une méthode lancer une seule fois quand on arriver dans une view donc au lancement dans l'app on va dans le gestionnaire puis cette methode utiliser qu'une fois
    super.initState();
    init();
  }

  init() async {
    token = (await PersistanceHandler().getTokenEDP())!;
  }

  @override
  Widget build(BuildContext context) {
    var largeurEcran = MediaQuery.of(context).size.width;
    var hauteurEcran = MediaQuery.of(context).size.height;
    var fractionEcran = 8;
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    const List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Home',
        style: optionStyle,
      ),
      Text(
        'Index 1: Business',
        style: optionStyle,
      ),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
      Text(
        'Index 3: Settings',
        style: optionStyle,
      ),
    ];

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
      backgroundColor: Colors.black,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => coursScreen()));
            },
            child: Container(
              color: Colors.white,
              alignment: Alignment(0, -0),
              height: (hauteurEcran / fractionEcran),
              width: 250,
              child: monWidget(widthFactorImg, heightFactorImg, "test"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => draganddropScreen()));
            },
            child: Container(
              height: (hauteurEcran / fractionEcran),
              color: Colors.black,
              alignment: Alignment(-0.3, -0),
              child: monWidget(widthFactorImg, heightFactorImg, "testcarr"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuestionnairePage()));
            },
            child: Container(
              height: (hauteurEcran / fractionEcran),
              color: Colors.black,
              alignment: Alignment(-0.5, -0),
              child: monWidget(widthFactorImg, heightFactorImg, "testcarr"),
            ),
          ),
          Container(
            color: Colors.black,
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
                              builder: (context) => QuestionnairePage()));
                    },
                    child: Container(
                      child: monWidget(1.0, heightFactorImg, "testcarr"),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: monWidgetGIF(1.0, 4.0, "gifdanseshelou"),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            alignment: Alignment(0, -0),
            height: (hauteurEcran / fractionEcran),
            width: 250,
            child: monWidget(widthFactorImg, heightFactorImg, "test"),
          ),
          Container(
            height: (hauteurEcran / fractionEcran),
            color: Colors.black,
            alignment: Alignment(0.3, -0),
            child: monWidget(widthFactorImg, heightFactorImg, "testcarr"),
          ),
          Container(
            height: (hauteurEcran / fractionEcran),
            color: Colors.black,
            alignment: Alignment(0.5, -0),
            child: monWidget(widthFactorImg, heightFactorImg, "testcarr"),
          ),
          Container(
            color: Colors.black,
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
                    child: monWidgetGIF2(1.0, 4.0, "gifdanseshelou2"),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: monWidget(1.0, heightFactorImg, "testcarr"),
                  ),
                ),
                SizedBox(
                  width: 77,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            alignment: Alignment(0, -0),
            height: (hauteurEcran / fractionEcran),
            width: 250,
            child: monWidget(widthFactorImg, heightFactorImg, "test"),
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
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Color(0xFFFFFF75),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Color.fromARGB(255, 252, 68, 48),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
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
          }
          break;

        case 1:
          {
            currentcolors = const Color(0xFFFFFF75);
          }
          break;

        case 2:
          {
            currentcolors = const Color.fromARGB(255, 252, 68, 48);
          }
          break;
        case 3:
          {
            currentcolors = const Color(0xFF383838);
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
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          child: Image(
            image: AssetImage("assets/" + pathimg + ".jpg"),
          ),
        ),
      ),
    );
  }

  Widget monWidgetGIF(widthFactor, heightFactor, pathimg) {
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
