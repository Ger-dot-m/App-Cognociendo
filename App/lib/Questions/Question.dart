import 'package:flutter/material.dart';
import 'MultipleChoiceQuestion.dart';
import 'QuestionSet.dart';
import '../Tasks/Result.dart';
import '../JSON/Messages.dart';

Map<int, List> Registro = {
  0: ['2023-01-01', 7],
  1: ['2023-11-04', 4],
  2: ['2023-11-04', 4],
  3: ['2023-11-04', 4],
  4: ['2023-11-04', 4],
  5: ['2023-11-04', 4]
};

int diasTranscurridos(String? fecha) {
  DateTime fechaActual = DateTime.now();
  Duration diferencia =
      fechaActual.difference(DateTime.parse(fecha ?? '2023-01-01'));
  return diferencia.inDays;
}

int evaluar(Map respuestas) {
  int puntos = 0;
  for (int respuesta in respuestas.values) {
    puntos += respuesta;
  }

  return puntos;
}

class QuestionnairePage extends StatefulWidget {
  final String title;
  final int id;
  final String acces_token;
  QuestionnairePage(this.title, this.id, this.acces_token);

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  Map<String, int?> answers = {};
  void subir(int points, int eje, String token) {
    Map<String, String> entry = {
      'ejeID': '$eje',
      'puntaje': '$points',
      'diagnostico': 'Puntuación recibida: $points puntos'
    };
    postData(entry, '/crear_entrada/', token);
  }

  @override
  Widget build(BuildContext context) {
    String? fecha = Registro[widget.id]?[0];
    if (diasTranscurridos(fecha) >= 15) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(127, 0, 255, 1),
          title: Text(widget.title),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var question in all_questions[widget.id])
                  MultipleChoiceQuestionWidget(question, answers),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(127, 0, 255, 1),
          onPressed: () {
            int points = evaluar(answers);
            subir(points, widget.id, widget.acces_token);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(widget.id, points, 0),
              ),
            );
          },
          child: Icon(Icons.arrow_forward),
        ),
      );
    } else {
      return ResultPage(
          widget.id, Registro[widget.id]?[1], 15 - diasTranscurridos(fecha));
    }
  }
}
