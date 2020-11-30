//provider, stateful finns nedanför
//Problem: Går inte att stoppa null atm & inputText är inte private
import 'package:flutter/material.dart';
import 'model.dart';
import 'package:provider/provider.dart';

//addTask-sidna ska vara stateful
class AddTask extends StatelessWidget {
  final Todo task;
  AddTask(this.task);

  final TextEditingController checkForInput = TextEditingController();

  //Samma appBar som i huvudsidan
  //Bygger upp sidan med textfält och knappen m.h.a. andra widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addTaskCustomAppbar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_taskInputField(), _addButton(context)],
        ),
      ),
    );
  }

  Widget _addTaskCustomAppbar(context) {
    return (AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 25.0),
          onPressed: () => Navigator.of(context).pop()),
      //iconTheme: IconThemeData(color: Colors.black),
      title: Text("TIG169 TODO", style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.grey,
      centerTitle: true,
    ));
  }

  //Widget för att skapa textfältet
  Widget _taskInputField() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      height: 40.0,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        controller: checkForInput,
        decoration: InputDecoration(
          hintText: "What are you going to do?",
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
      ),
    );
  }

//Widget för add-knappen
  Widget _addButton(context) {
    return Consumer<MyState>(
      builder: (context, state, child) => FlatButton(

          //return Container(
          //  child: RaisedButton(
          onPressed: () {
            state.inputText = checkForInput.text;
            if (state.getInputText() == "") {
              //om textfältet är tomt händer inget när man klickar add
              print("Du försökte lägga till en tom textsträng");
            } else {
              Navigator.pop(context, Todo(title: state.getInputText()));
            }
          },
          child: Text('+ADD')),
    );
  }
}
