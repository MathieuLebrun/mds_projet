import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/score_response_model.dart';
import '../services/persistancehandler.dart';
import '../services/api_service.dart';

class draganddropScreen extends StatefulWidget {
  @override
  _draganddropScreenState createState() => _draganddropScreenState();
}

class _draganddropScreenState extends State<draganddropScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  List<ScoreResponseModel> ScoreAnimation = [];
  String accesstoken = "";
  String id = "";
  bool dataIsready = false;
  double scoremath = 0.0;
  double scorefrancais = 0.0;
  double scoreanglais = 0.0;

  @override
  void initState() {
    super.initState();

    recupScore();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  Future<void> recupScore() async {
    accesstoken = (await PersistanceHandler().getTokenEDP())!;
    id = (await PersistanceHandler().getID())!;
    List<ScoreResponseModel> scores =
        await APIService().getScores(id, accesstoken);
    setState(() {
      ScoreAnimation.addAll(scores);
      for (int i = 0; i < ScoreAnimation.length; i++) {
        int compteur = 0;
        for (int j = 0; j < ScoreAnimation[i].value.length; j++) {
          compteur += ScoreAnimation[i].value[j];
          print(compteur);
        }
        if (ScoreAnimation[i].category == "math") {
          setState(() {
            scoremath = compteur.toDouble();
          });
          if (ScoreAnimation[i].category == "anglais") {
            setState(() {
              scoreanglais = compteur.toDouble();
            });
          }
          if (ScoreAnimation[i].category == "francais") {
            setState(() {
              scorefrancais = compteur.toDouble();
            });
          }
        }
      }
    });
    setState(() {
      dataIsready = true;
      _controller1 = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000),
      )..forward(from: 0);

      _animation1 = Tween<double>(begin: 0, end: scoreanglais.toDouble())
          .animate(_controller1);

      _controller2 = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000),
      )..forward(from: 0);

      _animation2 = Tween<double>(begin: 0, end: scorefrancais.toDouble())
          .animate(_controller2);

      _controller3 = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000),
      )..forward(from: 0);

      _animation3 = Tween<double>(begin: 0, end: scoremath.toDouble())
          .animate(_controller3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: (dataIsready)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Progression",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Asdean',
                      ),
                    ),
                    SizedBox(
                      height: 75,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        'Anglais :',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 200,
                      height: 20,
                      child: AnimatedBuilder(
                        animation: _animation1,
                        builder: (BuildContext context, Widget? child) {
                          return LinearProgressIndicator(
                            value: _animation1.value / 100,
                            backgroundColor: Colors.grey[300],
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(scoreanglais.toString()),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        'Français:',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 200,
                      height: 20,
                      child: AnimatedBuilder(
                        animation: _animation2,
                        builder: (BuildContext context, Widget? child) {
                          return LinearProgressIndicator(
                            value: _animation2.value / 100,
                            backgroundColor: Colors.grey[300],
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(scorefrancais.toString()),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        'Math :',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 200,
                      height: 20,
                      child: AnimatedBuilder(
                        animation: _animation3,
                        builder: (BuildContext context, Widget? child) {
                          return LinearProgressIndicator(
                            value: _animation3.value / 100,
                            backgroundColor: Colors.grey[300],
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(scoremath.toString()),
                  ],
                ),
              ],
            )
          : CircularProgressIndicator(),
    );
  }
}
