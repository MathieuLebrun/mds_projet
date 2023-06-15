import 'package:flutter/material.dart';
import 'package:mds_project/views/mainScreen.dart';
import 'package:mds_project/services/api_service.dart';
import 'package:mds_project/services/persistancehandler.dart';
import '../models/score_response_model.dart';
import '../utilities/global.dart';
import '../models/score_modify_model.dart';

class Questionnaire extends StatefulWidget {
  final String question;
  final int index;
  final String matiere;
  const Questionnaire(
      {super.key,
      required this.question,
      required this.index,
      required this.matiere});
  @override
  QuestionnaireState createState() => QuestionnaireState();
}

class QuestionnaireState extends State<Questionnaire> {
  late List<Map<String, Object>> question;
  bool dataisready = false;
  @override
  void initState() {
    // C'est ici que l'on initialise les données nécessaires.
    super.initState();
    selectQuestionnaire();
  }

  void selectQuestionnaire() {
    // Cette méthode sélectionne le questionnaire en fonction de la question transmise pars le main screen ex:si le joueur clique sur le bouton le 2eme niveau en ayant la matiere anglais selectionne cela va prendre le questionnaire anglais2
    switch (widget.question) {
      case "Math1":
        {
          question = Math1;
          dataisready = true;
        }
        break;
      case "Math2":
        {
          question = Math2;
          dataisready = true;
        }
        break;

      case "Math3":
        {
          question = Math3;
          dataisready = true;
        }
        break;
      case "Anglais1":
        {
          question = Anglais1;
          dataisready = true;
        }
        break;
      case "Anglais2":
        {
          question = Anglais2;
          dataisready = true;
        }
        break;
      case "Anglais3":
        {
          question = Anglais3;
          dataisready = true;
        }
        break;
      case "Francais1":
        {
          question = Francais1;
          dataisready = true;
        }
        break;
      case "Francais2":
        {
          question = Francais2;
          dataisready = true;
        }
        break;
      case "Francais3":
        {
          question = Francais2;
          dataisready = true;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Questionnaire'),
        ),
        body: (dataisready)
            ? QuestionnairePage(
                questions: question,
                index: widget.index,
                matiere: widget.matiere,
              )
            : const CircularProgressIndicator());
  }
}

class QuestionnairePage extends StatefulWidget {
  final List<Map<String, Object>> questions;
  final int index;
  final String matiere;
  const QuestionnairePage({
    super.key,
    required this.questions,
    required this.index,
    required this.matiere,
  });
  @override
  QuestionnairePageState createState() => QuestionnairePageState();
}

class QuestionnairePageState extends State<QuestionnairePage> {
  int _questionIndex = 0;
  int _score = 0;
  bool repondu = false;

  void _answerQuestion(int score) {
    // Cette méthode est appelée lorsque l'utilisateur répond à une question.
    // Elle met à jour le score et passe à la question suivante.
    setState(() {
      _score += score;
      _questionIndex++;
    });
  }

  void _resetQuestionnaire() {
    // Cette méthode est appelée lorsque l'utilisateur souhaite recommencer le questionnaire.
    // Elle réinitialise le score et l'index de la question.
    setState(() {
      _score = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _questionIndex <
              widget.questions
                  .length // j'affiche le questionnaire tant qu'il reste des questions sinon j'affiche l'écran de résultat
          ? Quiz(
              questionIndex: _questionIndex,
              questions: widget.questions,
              answerQuestion: _answerQuestion,
            )
          : Result(_score, _resetQuestionnaire, widget.index, widget.matiere),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  const Quiz({
    super.key,
    required this.questions,
    required this.questionIndex,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Afficher la question actuelle
        Question(
          questions[questionIndex]['questionText'].toString(),
        ), // Créer une liste de widgets Answer en fonction des réponses disponibles pour la question actuelle
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

  const Question(this.questionText, {super.key});

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

  const Answer(this.answerText, this.selectHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        onPressed: selectHandler,
        child: Text(answerText),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int score;
  final VoidCallback resetHandler;
  final int index;
  final String matiere;

  const Result(this.score, this.resetHandler, this.index, this.matiere,
      {super.key});

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            resultPhrase,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Score : $score ',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            onPressed: resetHandler,
            child: const Text("recommencer"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Text("Je retourne dans l'écran principal"),
              onPressed: () async {
                // Obtenir le token d'accès depuis PersistanceHandler
                String? accesToken = await PersistanceHandler().getTokenEDP();
                // Obtenir l'ID depuis PersistanceHandler
                String? id = await PersistanceHandler().getID();
                // Obtenir les scores depuis APIService
                List<ScoreResponseModel> scores =
                    await APIService().getScores(id!, accesToken!);

                // Créer le modèle ScoreModifyModel mis à jour
                ScoreModifyModel? model =
                    scoreUpdated(score, scores, index, matiere);
                // Appeler la méthode addOrUpdateScore de APIService pour ajouter ou mettre à jour le score
                var response =
                    await APIService().addOrUpdateScore(id, accesToken, model!);
                if (context.mounted) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const mainScreen()));
                }
              }),
        ],
      ),
    );
  }

// méthode récupérant le  score existant ou ajoute le score de la nouvelle matière
  ScoreModifyModel? scoreUpdated(
      int score, List<ScoreResponseModel> scores, int index, String matiere) {
    if (matiere.toLowerCase() == "math") {
      ScoreModifyModel scoreUpdated = ScoreModifyModel(
          category: 'math', value: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      for (int j = 0; j < scores[0].value.length; j++) {
        if (index == j) {
          scoreUpdated.value[j] = score;
        } else {
          scoreUpdated.value[j] = scores[0].value[j];
        }
      }
      return scoreUpdated;
    }
    if (matiere.toLowerCase() == "francais") {
      ScoreModifyModel scoreUpdated = ScoreModifyModel(
          category: 'francais', value: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      for (int j = 0; j < scores[1].value.length; j++) {
        if (index == j) {
          scoreUpdated.value[j] = score;
        } else {
          scoreUpdated.value[j] = scores[1].value[j];
        }
      }
      return scoreUpdated;
    }
    if (matiere.toLowerCase() == "anglais") {
      ScoreModifyModel scoreUpdated = ScoreModifyModel(
          category: 'anglais', value: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      for (int j = 0; j < scores[2].value.length; j++) {
        if (index == j) {
          scoreUpdated.value[j] = score;
        } else {
          scoreUpdated.value[j] = scores[2].value[j];
        }
      }
      return scoreUpdated;
    }
    return null;
  }
}
