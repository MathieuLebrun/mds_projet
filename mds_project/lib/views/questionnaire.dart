import 'package:flutter/material.dart';
import 'package:mds_project/mainScreen.dart';
import 'package:mds_project/services/api_service.dart';
import 'package:mds_project/services/persistancehandler.dart';

import '../models/score_modify_model.dart';

class QuestionnairePage extends StatefulWidget {
  final List<Map<String, Object>> questions;
  QuestionnairePage({required this.questions});
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _questionIndex = 0;
  int _score = 0;
  bool repondu = false;

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _questionIndex++;
    });
  }

  void _resetQuestionnaire() {
    setState(() {
      _score = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),
      body: _questionIndex < widget.questions.length
          ? Quiz(
              questionIndex: _questionIndex,
              questions: widget.questions,
              answerQuestion: _answerQuestion,
            )
          : Result(_score, _resetQuestionnaire),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  Quiz({
    required this.questions,
    required this.questionIndex,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText'].toString(),
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
            answer["text"].toString(),
            () => answerQuestion(answer['score']),
          );
        }).toList(),
      ],
    );
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        questionText,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final String answerText;
  final VoidCallback selectHandler;

  Answer(this.answerText, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
        child: Text(answerText),
        onPressed: selectHandler,
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int score;
  final VoidCallback resetHandler;

  Result(this.score, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (score >= 3) {
      resultText = 'Bravo ! Vous avez réussi le questionnaire !';
    } else {
      resultText = 'Dommage, vous pouvez réessayer.';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          resultPhrase,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'Score : $score / 4',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
          ),
          child: Text("recommencer"),
          onPressed: resetHandler,
        ),
        // la ici rajouter le setteur du score et le button pour revenir a l'écran principal
        SizedBox(height: 10),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
            child: Text("Je retourne dans l'écran principal"),
            onPressed: () async {
              ScoreModifyModel model = ScoreModifyModel(
                category: 'math',
                value: [
                  score,
                  score,
                  score,
                  score,
                  score,
                  score,
                  score,
                  score,
                  score,
                  score
                ],
              );
              String? accesToken = await PersistanceHandler().getTokenEDP();
              String? id = await PersistanceHandler().getID();
              var response =
                  await APIService().addOrUpdateScore(id!, accesToken!, model);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => mainScreen(
                            onChangedStep: (int) {},
                          )));
            }),
      ],
    );
  }
}
