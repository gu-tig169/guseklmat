import 'package:flutter/material.dart';
import 'main.dart';

//addTask-sidna ska vara stateful
class AddTask extends StatefulWidget {
  _AddTask createState() => _AddTask();
}

class _AddTask extends State<AddTask> {
  TextEditingController checkForInput = TextEditingController();

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
          children: [_taskInputField(), _addButton()],
        ),
      ),
    );
  }

  //Widget för att skapa textfältet
  Widget _taskInputField() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: TextField(
        decoration: InputDecoration(hintText: "What are you going to do?"),
        controller: checkForInput,
        //onSubmitted: (String value),
      ),
    );
  }

//Widget för add-knappen
  Widget _addButton() {
    return Container(
      child: RaisedButton(
          onPressed: () {
            add();
            print("add");
          },
          child: Text('+ADD')),
    );
  }

  //Metod för att skapa funktionaliteten för "add-knappen"
  //Och för att ta sig tillbaka till huvudsidan
  void add() {
    Navigator.of(context).pop(checkForInput.text);
  }
}
