import 'package:flutter/material.dart';
import 'package:mds_project/services/persistancehandler.dart';

class mainScreen extends StatefulWidget {
  final Function(int) onChangedStep;
  const mainScreen({Key? key, required this.onChangedStep}) : super(key: key);

  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  late String token;

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
    var widthFactorImg = 0.22;
    var heightFactorImg = 0.8;
    return Scaffold(
        /*
        appBar: AppBar(
          title: const Text('Zhéro'),
        ), */
        backgroundColor: Colors.black,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                widget.onChangedStep(4);
              },
              child: Container(
                color: Colors.black,
                alignment: Alignment(0, -0),
                height: (hauteurEcran / fractionEcran),
                width: 250,
                child: monWidget(widthFactorImg, heightFactorImg, "test"),
              ),
            ),
            Container(
              height: (hauteurEcran / fractionEcran),
              color: Colors.black,
              alignment: Alignment(-0.3, -0),
              child: monWidget(widthFactorImg, heightFactorImg, "testcarr"),
            ),
            Container(
              height: (hauteurEcran / fractionEcran),
              color: Colors.black,
              alignment: Alignment(-0.5, -0),
              child: monWidget(widthFactorImg, heightFactorImg, "testcarr"),
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
                    child: Container(
                      child: monWidget(1.0, heightFactorImg, "testcarr"),
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
        ));
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
