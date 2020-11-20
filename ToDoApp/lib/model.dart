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
  String filterValue = "All";
  
  //Vanliga listan
  List<Todo> _tasks = new List();
  
  //Metod för att skapa en ny filtrerad lista
  List<Todo> filtering(List<Todo> _tasks, String filterValue) {
    List<Todo> filteredTasks;
    if (filterValue == "All") {
      filteredTasks = _tasks;
      print("all");
    } else if (filterValue == "Done") {
      filteredTasks = _tasks.where((i) => i.done).toList();
      print("done");
    } else {
      filteredTasks = _tasks.where((i) => !i.done).toList();
      print("undone");
    }
    print(" värde " + filterValue);
    return filteredTasks;
  }

  //Getter för listan _tasks, inkluderar testobjekt
  List get getTasks {
    if (_tasks.length == 0) {
      var task = new Todo(text: "task1", done: false);
      _tasks.add(task);
      var task2 = new Todo(text: "task2", done: false);
      _tasks.add(task2);
      var task3 = new Todo(text: "task3", done: false);
      _tasks.add(task3);
    }
    //Returnerar den filtrerade listan från filtering
    return filtering(_tasks, filterValue);
    //Returnerar den "vanliga" listan
    //return _tasks; 
  }

  //Metod för få namnet på en task, samt stryka över om done=true;
  getTask(done, index) {
    if (_tasks[index].done == false) {
      return Text(_tasks[index].text);
    } else {
      return Text(_tasks[index].text,
          style: TextStyle(decoration: TextDecoration.lineThrough));
    }
  }

  //Metod för att få värdet på done
  bool getDone(index) {
    return _tasks[index].done;
  }

  //Metod för att lägga till task
  void addTask(Todo task) {
    _tasks.add(task);
    notifyListeners();
  }

  //Metod för att sätta done till true, m.h.a. completed i Todo class
  void setDone(index) {
    _tasks[index].completed();
    notifyListeners();
  }

  //Metod för att ta bort task
  void delete(index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
