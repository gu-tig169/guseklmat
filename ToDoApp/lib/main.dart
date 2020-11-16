/*TODO
 - Kunna stryka över en task när checkbox klickas i
 - Se till att första-sidan uppdateras när man lägger till en till task från addTask
 - Skapa funktionalitet till filterlistan
 
 Funktionalitet:
 - Det går att klicka i en checkbox
 - Det går att ta bort en task genom att klicka på krysset
 - Det går att trycka på en funktionslös meny uppe till höger
 - Det går att ta sig till addTask-sidan genom att trycka på "+"
 - Det går att skriva i textfältet och klicka på add
    - Den nya tasken läggs till, men man måste hot-reloada för att tasken ska synas
*/
import 'package:flutter/material.dart';
import 'addTask.dart';

//Startar appen
void main() => runApp(MyApp());

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

//Första-sidan som är stateful för att kunna ändra state under körning
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Temporär statiskt test-lista som skapas en gång när appen startar
  List<Todo> tasks = List<Todo>();
  //Lägger till lite testobjekt i listan
  @override
  void initState() {
    tasks.add(Todo(title: "task 1"));
    tasks.add(Todo(title: "task 2"));
    tasks.add(Todo(title: "task 3"));
    tasks.add(Todo(title: "task 4"));
    tasks.add(Todo(title: "task 5"));
    tasks.add(Todo(title: "task 6"));
    tasks.add(Todo(title: "task 7"));
    super.initState();
  }

  //Widget för att bygga första-sidan och appBaren
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("TIG169 TODO"),
          centerTitle: true,
          actions: <Widget>[
            _popUpButton() //Kallar på widgeten som skapar meny-knappen i appBaren
          ]),
      body:
          buildBody(), //Kallar på widgeten buildBody för att skapa innehållet i body
      floatingActionButton: FloatingActionButton(
        //skapar knapp för ta sig till addTask-sidan
        child: Icon(Icons.add),
        onPressed: () => navigateAddTask(),
      ),
    );
  }

  //Widgeten som skapar menyn och använder sig av listan Choices för sitt innehåll som nu är funktionslöst
  Widget _popUpButton() {
    return PopupMenuButton<String>(
      onSelected: choiceAction,
      itemBuilder: (BuildContext context) {
        return Choices.choices.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  //Widget som bygger listan som visas i bodyn
  Widget buildBody() {
    return ListView.builder(
        itemBuilder: (context, index) =>
            buildTask(tasks[index]), //Skapar en loop
        itemCount: tasks.length //värdet som används för att stoppa loopen

        );
  }

  //Widget som buildBody använder sig av för att skapa varje "ListTile-objekt" i listan
  //Består av checkboxen, namnet på tasken och en kryss-icon för att ta bort ett objekt ur listan
  Widget buildTask(Todo task) {
    return ListTile(
      leading: Checkbox(
          value: task.done,
          onChanged: (bool done) {
            setState(() {
              task.done = done;
            });
          }),
      title: Text(task.title),
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          setState(() {
            removeTask(task);
            print("Delete-button works");
          });
        },
      ),
    );
  }

  //Metod för att ta bort en task, används i buildTask när statet ändras
  void removeTask(Todo task) {
    tasks.remove(task);
  }

  //Metod som kallas av build och som tar fram addTask-sidan
  //if-statementet avgör om man från addTask-sidan tar sig tillbaka genom pilen
  //eller add-knappen som då skickar med en ny task
  void navigateAddTask() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddTask();
    })).then((title) {
      if (title != null) {
        addTodo(Todo(title: title));
        print("!null");
      } else {
        print("null");
      }
    });
  }

  //Metod som används av navigateAddTask för att lägga till en ny task
  void addTodo(Todo task) {
    tasks.add(task);
  }

  //Metod för veta vilken alternativ som väljs från menyn i appBaren
  void choiceAction(String choice) {
    if (choice == Choices.All) {
      print('All');
    } else if (choice == Choices.Done) {
      print('Done');
    } else if (choice == Choices.Undone) {
      print('Undone');
    }
  }
}

//Klass för todo-objekt
class Todo {
  String title; //namnet på task
  bool done; //status på checkbox

  Todo({
    this.title,
    this.done =
        false, //sätter till false för att checkbox inte ska vara ibockad
  });
}

//Klass som deklarerar alternativen till menyn samt skapar en lista av dem.
class Choices {
  static const String All = "All";
  static const String Done = "Done";
  static const String Undone = "Undone";
  static const List<String> choices = <String>[All, Done, Undone];
}
