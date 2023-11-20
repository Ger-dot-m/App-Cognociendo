import 'package:flutter/material.dart';

class MultipleChoiceQuestion {
  final String question;
  final List<String> options;

  MultipleChoiceQuestion(this.question, this.options);
}

class MultipleChoiceQuestionWidget extends StatefulWidget {
  final MultipleChoiceQuestion questionData;
  final Map<String, int?> answer;

  MultipleChoiceQuestionWidget(this.questionData, this.answer);

  @override
  _MultipleChoiceQuestionWidgetState createState() =>
      _MultipleChoiceQuestionWidgetState();
}

class _MultipleChoiceQuestionWidgetState
    extends State<MultipleChoiceQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              widget.questionData.question,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (int i = 0; i < widget.questionData.options.length; i++)
            RadioListTile(
              value: i,
              groupValue: widget.answer[widget.questionData.question],
              title: Text(
                widget.questionData.options[i],
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onChanged: (int? value) {
                setState(() {
                  widget.answer[widget.questionData.question] = value;
                });
              },
            ),
        ],
      ),
    );
  }
}
