import 'package:flutter/material.dart';
import 'package:mds_project/mainScreen.dart';
import 'package:mds_project/services/api_service.dart';
import 'package:mds_project/services/persistancehandler.dart';

import '../models/score_modify_model.dart';

class QuestionnairePage extends StatefulWidget {
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'Quelle est la valeur de pi ?',
      'answers': [
        {'text': '3', 'score': 0},
        {'text': '3,14', 'score': 1},
        {'text': '3,1416', 'score': 0},
        {'text': '22/7', 'score': 0},
      ],
    },
    {
      'questionText': 'Quelle est la formule de l\'aire d\'un carré ?',
      'answers': [
        {'text': 'A = c x c', 'score': 1},
        {'text': 'A = l x L', 'score': 0},
        {'text': 'A = (c + c) x (c + c)', 'score': 0},
        {'text': 'A = c²', 'score': 0},
      ],
    },
    {
      'questionText': 'Quelle est la formule de l\'aire d\'un rectangle ?',
      'answers': [
        {'text': 'A = c x c', 'score': 0},
        {'text': 'A = l x L', 'score': 1},
        {'text': 'A = (c + c) x (c + c)', 'score': 0},
        {'text': 'A = l x h', 'score': 0},
      ],
    },
    {
      'questionText':
          'Quelle est la formule de la circonférence d\'un cercle ?',
      'answers': [
        {'text': 'C = 2 x pi x r', 'score': 1},
        {'text': 'C = pi x r²', 'score': 0},
        {'text': 'C = l x L', 'score': 0},
        {'text': 'C = 2 x r', 'score': 0},
      ],
    },
  ];

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
      body: _questionIndex < _questions.length
          ? Quiz(
              questionIndex: _questionIndex,
              questions: _questions,
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
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(
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
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
            child: Text("Je retourne dans l'écran principal mon gaté"),
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
