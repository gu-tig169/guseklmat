/*
 Funktionalitet:
 - Det går att klicka i en checkbox och genomstryka tasks
 - Det går att ta bort en task genom att klicka på krysset
 - Det går att ta sig till addTask-sidan genom att trycka på "+"
 - Det går att skriva i textfältet och klicka på add
    - Har man fyllt i något så läggs det till och man skickas tillbaka till listan
    - Har man inte fyllt i något så händer ingenting
 - Menyn för filtrering finns och funkar nu
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addTask.dart';
import 'model.dart';

//Startar appen
void main() {
  var state = MyState();
  runApp(
    ChangeNotifierProvider(create: (context) => state, child: MyApp()),
  );
}

//Huvudklassen som skapar en materialApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TIG169",
      home: HomePage(),
    );
  }
}

//Första-sidan som jag har ändrat till stateless och använder istället provider
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("TIG169 TODO"),
          centerTitle: true,
          actions: [_popupButton()]),
      body: _buildBody(
          //Kallar på widgeten buildBody för att skapa innehållet i body
          context),
      floatingActionButton: FloatingActionButton(
          //skapar knapp för ta sig till addTask-sidan
          child: Icon(Icons.add),
          onPressed: () async {
            var newTask = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTask(Todo())));
            if (newTask != null) {
              Provider.of<MyState>(context, listen: false).addTask(newTask);
            }
          }),
    );
  }

  //Widget som bygger listan som visas i bodyn
  Widget _buildBody(BuildContext context) {
    return Consumer<MyState>(
      builder: (context, state, child) => ListView.builder(
          itemCount: state.getTasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Checkbox(
                value: state.getDone(index),
                onChanged: (bool done) {
                  state.setDone(index, done);
                },
              ),
              title: state.getTask(state, index),
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {//Provider.of<MyState>(context, listen: false).delete(index);
                  state.delete(index);
                },
              ),
            );
          }),
    );
  }

  Widget _popupButton() {
    return Consumer<MyState>(
        builder: (context, state, child) => PopupMenuButton(
              onSelected: (newValue) {
                state.setFilterValue(newValue);
                state.useFilter();
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "All",
                  child: Text("All"),
                ),
                PopupMenuItem(
                  value: "Done",
                  child: Text("Done"),
                ),
                PopupMenuItem(
                  value: "Undone",
                  child: Text("Undone"),
                ),
              ],
            ));
  }
}
