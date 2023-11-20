import 'package:flutter/material.dart';

class ChecklistItem {
  final int id;
  final String title;
  bool isChecked;
  ChecklistItem(this.id, this.title, this.isChecked);
}

class ChecklistItemWidget extends StatefulWidget {
  final ChecklistItem item;
  final Map<int, bool> score;
  ChecklistItemWidget(this.item, this.score);

  @override
  _ChecklistItemWidgetState createState() => _ChecklistItemWidgetState();
}

class _ChecklistItemWidgetState extends State<ChecklistItemWidget> {
  bool showAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            decoration:
                widget.item.isChecked ? TextDecoration.lineThrough : null,
          ),
          child: Text(widget.item.title),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: widget.item.isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  widget.score[widget.item.id] = newValue ?? false;
                  widget.item.isChecked = newValue ?? false;
                  showAnimation = true;
                  var state = widget.score;
                  print("Score: $state");
                });
              },
            ),
            if (showAnimation)
              Icon(
                Icons.add,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
