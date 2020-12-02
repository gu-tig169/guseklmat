//Klass för sidan att lägga till objekt i listan
import 'package:flutter/material.dart';
import 'model.dart';
import 'package:provider/provider.dart';

//addTask-sidan är ändrad till Stateless och jag använder provider istället
class AddTask extends StatelessWidget {
  final Todo task;
  AddTask(this.task);

  final TextEditingController checkForInput = TextEditingController();

  //Bygger upp sidan med textfält och knappen m.h.a. andra widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addTaskCustomAppbar(context),
      backgroundColor:
          Provider.of<MyState>(context, listen: false).getMainColor(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_taskInputField(context), _addButton(context)],
        ),
      ),
    );
  }

  //Appbaren för sidan "addTask"
  Widget _addTaskCustomAppbar(context) {
    return (AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color:
                  Provider.of<MyState>(context, listen: false).getThirdColor(),
              size: 25.0),
          onPressed: () => Navigator.of(context).pop()),
      title: Text("TIG169 TODO",
          style: TextStyle(
              color: Provider.of<MyState>(context, listen: false)
                  .getThirdColor())),
      backgroundColor:
          Provider.of<MyState>(context, listen: false).getSecondColor(),
      centerTitle: true,
    ));
  }

  //Widget för att skapa textfältet
  Widget _taskInputField(context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 30),
      height: 40.0,
      color: Colors.white,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        controller: checkForInput,
        style: TextStyle(
          fontSize: 20.0,
          color: Provider.of<MyState>(context, listen: false).getThirdColor(),
        ),
        decoration: InputDecoration(
          hintText: "What are you going to do?",
          hintStyle: TextStyle(
              fontSize: 20.0,
              color: Provider.of<MyState>(context, listen: false)
                  .getSecondColor()),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Provider.of<MyState>(context, listen: false)
                    .getThirdColor(),
                width: 1.0),
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
      builder: (context, state, child) => RaisedButton(
        color: state.getSecondColor(),
        onPressed: () {
          state.inputText = checkForInput.text;
          if (state.getInputText() == "") {
            //om textfältet är tomt händer inget när man klickar add
            print("Du försökte lägga till en tom textsträng");
          } else {
            Navigator.pop(context, Todo(title: state.getInputText()));
          }
        },
        child: Text('+ADD',
            style: TextStyle(color: state.getThirdColor(), fontSize: 15.0)),
      ),
    );
  }
}
