import 'package:flutter/material.dart';
import '../Questions/Question.dart';

class OptionItem extends StatelessWidget {
  final String title;
  final int id;
  final String acces_token;
  OptionItem(this.title, this.id, this.acces_token);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Color.fromRGBO(127, 0, 255, 1),
      color: Color.fromRGBO(255, 255, 255, 1),
      elevation: 20,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(127, 0, 255, 1),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionnairePage(title, id, acces_token),
            ),
          );
        },
      ),
    );
  }
}
