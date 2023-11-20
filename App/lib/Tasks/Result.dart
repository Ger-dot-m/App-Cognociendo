import 'package:flutter/material.dart';
import 'Checklist.dart';
import 'tasks.dart';

class ResultPage extends StatefulWidget {
  final int id;
  final int points;
  final int proximo;
  ResultPage(this.id, this.points, this.proximo);
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    Map<int, bool> score = {};
    int eje = widget.id;
    int faltan = widget.proximo;
    int puntos = widget.points;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(127, 0, 255, 1),
          title: Text('Eje $eje. Faltan: $faltan días. Puntaje: $puntos.'),
        ),
        body: Body(score));
  }
}

Container Body(Map<int, bool> score) {
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var item in checklistItems) ChecklistItemWidget(item, score),
        ],
      ),
    ),
  );
}
