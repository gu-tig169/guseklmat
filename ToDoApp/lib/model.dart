import 'package:flutter/material.dart';
import 'apiTalker.dart';

class Todo {
  String id; //id:t för som används för att kommunicera med API:t
  String title; //namnet på task
  bool done; //status på checkbox

  Todo(
      {this.id,
      this.title,
      this.done =
          false //sätter till false för att checkbox inte ska vara ibockad
      });

  //Konvertering till json
  static Map<String, dynamic> toJson(Todo task) {
    return {
      'title': task.title,
      'done': task.done, 
    };
  }

  //Konvertering från json
  static Todo fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json['id'],
        title: json['title'],
        done: json['done'] 
        );
  }

  //Anävnds för att ändra värdet på done
  void completed() {
    done = !done;
  }
}

class MyState extends ChangeNotifier {

  //Variabel för att ta emot sträng i texftfield
  String _inputText = "";

  //Variabel för filtrering
  String _filterValue = "All";

  //Vanliga listan
  List<Todo> _tasks = new List();

  //Filtrerade listan
  List<Todo> _filteredTasks;

  //Metod för att skapa en ny filtrerad lista
  List<Todo> filtering(List<Todo> _tasks, String _filterValue) {
    if (_filterValue == "All") {
      _filteredTasks = _tasks;
    } else if (_filterValue == "Done") {
      _filteredTasks = _tasks.where((i) => i.done == true).toList();
    } else if (_filterValue == "Undone") {
      _filteredTasks = _tasks.where((i) => i.done == false).toList();
    }
    return _filteredTasks;
  }

  //Metod för att hämta API-listan
  Future fetchList() async {
    print("Fetching...");
    List<Todo> dbList = await APITalker.fetchTask();
    _tasks = dbList;
    notifyListeners();
    print("Finished fetching ");
  }

  //Metod för att lägga till task
  void addTask(Todo task) async {
    _filterValue = "All";
    print("Posting " + task.title);
    await APITalker.postTask(task);
    print('Finished posting ' + task.title);
    await fetchList();
  }

  //Metod för att ta bort en task
  void delete(index) async {
    print("Deleting " + getTasks[index].title + " at index: " + index.toString());
    var tmp = getTasks[index].title;
    await APITalker.deleteTask(getTasks[index].id);
    print("Deleting of " + tmp + " is done.");
    await fetchList();
  }

  //Metod för att sätta done till true, m.h.a. completed i Todo class
  void setDone(index, bool done) async {
    print("Updating done status on " + getTasks[index].title);
    getTasks[index].completed();
    await APITalker.updateDone(getTasks[index], getTasks[index].id);
    print("Finished updating " + getTasks[index].title + " status.");
    await fetchList();
  }

  //Metod för att sätta filterValue till valt värde i popupButton.
  void setFilterValue(newValue) {
    _filterValue = newValue;
  }

  //Metod för att kunna ändra värdet på _inputText
  set inputText(text) {
    _inputText = text;
  }

  //Metod för att få värdet på done
  bool getDone(index) {
    return getTasks[index].done;
  }

  //Getter för listan _tasks,  testobjekten är nu borttagna
  List get getTasks {
    if (_tasks.length == 0) {
      print("List is empty");
    }
    return filtering(_tasks, _filterValue);
  }

  //Metod för få namnet på en task, samt stryka över om done=true;
  getTask(index) {
    if (getTasks[index].done == false) {
      return Text(getTasks[index].title,
          style: TextStyle(
            fontSize: 20,
          ));
    } else {
      return Text(getTasks[index].title,
          style: TextStyle(
              fontSize: 20,
              decoration: TextDecoration.lineThrough,
              decorationThickness: 2.5));
    }
  }

  //Metod för att kunna hämta variablen _inputText i addTask-klassen
  getInputText() => _inputText;

  //Väldigt simpel metod som används i _popupButtom för kalla på metoden som filtrerar listan
  useFilter() {
    notifyListeners();
    return filtering;
  }
}
