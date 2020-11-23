import 'package:flutter/material.dart';
import 'model.dart';

//addTask-sidna ska vara stateful
class AddTask extends StatefulWidget {
  final Todo task;
  AddTask(this.task);

  _AddTask createState() => _AddTask(); //(task)
}

class _AddTask extends State<AddTask> {
  TextEditingController checkForInput = TextEditingController();
  String text;

  _AddTask() {
    checkForInput.addListener(() {
      setState(() {
        text = checkForInput.text;
      });
    });
  }

  //Samma appBar som i huvudsidan
  //Bygger upp sidan med textfält och knappen m.h.a. andra widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TIG169 TODO'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_taskInputField(), _addButton(context)],
        ),
      ),
    );
  }

  //Widget för att skapa textfältet
  Widget _taskInputField() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: TextFormField(
        controller: checkForInput,
        decoration: InputDecoration(hintText: "What are you going to do?"),
      ),
    );
  }

//Widget för add-knappen
  Widget _addButton(context) {
    return Container(
      child: RaisedButton(
          onPressed: () {
            if (text == null) {
              //om textfältet är null händer inget när man klickar add
              print("Du försökte lägga till en tom textsträng");
            } else {
              Navigator.pop(context, Todo(text: text));
            }
          },
          child: Text('+ADD')),
    );
  }
}
