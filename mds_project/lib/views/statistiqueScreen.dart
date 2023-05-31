import 'package:flutter/material.dart';

import '../models/score_response_model.dart';
import '../services/persistancehandler.dart';
import '../services/api_service.dart';

class StatistiqueScreen extends StatefulWidget {
  const StatistiqueScreen({super.key});

  @override
  StatistiqueScreenState createState() => StatistiqueScreenState();
}

class StatistiqueScreenState extends State<StatistiqueScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  List<ScoreResponseModel> scoreAnimation = [];
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
      scoreAnimation.addAll(scores);
      for (int i = 0; i < scoreAnimation.length; i++) {
        int compteur = 0;
        for (int j = 0; j < scoreAnimation[i].value.length; j++) {
          compteur += scoreAnimation[i].value[j];
        }
        if (scoreAnimation[i].category == "math") {
          setState(() {
            scoremath = compteur.toDouble();
          });
        }

        if (scoreAnimation[i].category == "anglais") {
          setState(() {
            scoreanglais = compteur.toDouble();
          });
        }
        if (scoreAnimation[i].category == "francais") {
          setState(() {
            scorefrancais = compteur.toDouble();
          });
        }
      }
    });
    setState(() {
      dataIsready = true;

      _controller1 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000),
      )..forward(from: 0);

      _animation1 = Tween<double>(begin: 0, end: scoreanglais.toDouble())
          .animate(_controller1);

      _controller2 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000),
      )..forward(from: 0);

      _animation2 = Tween<double>(begin: 0, end: scorefrancais.toDouble())
          .animate(_controller2);

      _controller3 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000),
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
                  children: const [
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
                    const SizedBox(
                      width: 80,
                      child: Text(
                        'Anglais :',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 200,
                      height: 20,
                      child: AnimatedBuilder(
                        animation: _animation1,
                        builder: (BuildContext context, Widget? child) {
                          return LinearProgressIndicator(
                            value: _animation1.value / 100,
                            backgroundColor: Colors.grey[300],
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(Colors.red),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(scoreanglais.toString()),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text(
                        'Français:',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 200,
                      height: 20,
                      child: AnimatedBuilder(
                        animation: _animation2,
                        builder: (BuildContext context, Widget? child) {
                          return LinearProgressIndicator(
                            value: _animation2.value / 100,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.green),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(scorefrancais.toString()),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text(
                        'Math :',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 200,
                      height: 20,
                      child: AnimatedBuilder(
                        animation: _animation3,
                        builder: (BuildContext context, Widget? child) {
                          return LinearProgressIndicator(
                            value: _animation3.value / 100,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(scoremath.toString()),
                  ],
                ),
              ],
            )
          : const CircularProgressIndicator(),
    );
  }
}
