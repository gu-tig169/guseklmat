import 'package:flutter/material.dart';

//Klass för todo-objekt
class Todo {
  String text; //namnet på task
  bool done; //status på checkbox

  Todo(
      {this.text,
      this.done =
          false //sätter till false för att checkbox inte ska vara ibockad
      });
  void completed() {
    done = !done;
  }
}

class MyState extends ChangeNotifier {
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
    } else if (_filterValue =="Undone"){
      _filteredTasks = _tasks.where((i) => i.done == false).toList();
    }
    return _filteredTasks;
  }

  //Getter för listan _tasks, inkluderar testobjekt
  List get getTasks {
    if (_tasks.length == 0) {
      var task = new Todo(text: "task1", done: true);
      _tasks.add(task);
      var task2 = new Todo(text: "task2", done: false);
      _tasks.add(task2);
      var task3 = new Todo(text: "task3", done: true);
      _tasks.add(task3);
      var task4 = new Todo(text: "task4", done: false);
      _tasks.add(task4);
      var task5 = new Todo(text: "task5", done: true);
      _tasks.add(task5);
      var task6 = new Todo(text: "task6", done: false);
      _tasks.add(task6);
      var task7 = new Todo(text: "task7", done: true);
      _tasks.add(task7);
    }
    return filtering(_tasks, _filterValue);
  }

  //Väldigt simpel metod som används i _popupButtom för kalla på metoden som filtrerar listan
  useFilter() {
    notifyListeners();
    return filtering;
  }

  //Metod för få namnet på en task, samt stryka över om done=true;
  getTask(done, index) {
    if (getTasks[index].done == false) {
      return Text(getTasks[index].text);
    } else {
      return Text(getTasks[index].text,
          style: TextStyle(decoration: TextDecoration.lineThrough));
    }
  }

  //Metod för att få värdet på done
  bool getDone(index) {
    return getTasks[index].done;
  }

  //Metod för att lägga till task
  void addTask(Todo task) {
    _filterValue = "All";
    getTasks.add(task);
    notifyListeners();
  }

  //Metod för att sätta done till true, m.h.a. completed i Todo class
  void setDone(index, bool testValue) {
    //index
    getTasks[index].completed();
    notifyListeners();
  }

  //Metod för att sätta filterValue till valt värde i popupButton.
  void setFilterValue(newValue) {
    _filterValue = newValue;
  }

    //Metod för att ta bort task. Ändra och använda "remove" kanske?
  void delete(index) {  
    getTasks.removeAt(index);
    notifyListeners();
  }
}
