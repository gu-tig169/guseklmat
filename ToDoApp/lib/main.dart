/*
 Funktionalitet:
Allt ska nu fungera
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';
import 'TodoListView.dart';

//Startar appen
void main() {
  var state = MyState();
  state.fetchList();
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
      home: TodoListView(),
    );
  }
}
