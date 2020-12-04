/* 
Min lista,
https://todoapp-api-vldfm.ondigitalocean.app/todos?key=8d656188-4d49-475c-92f4-d6ffb2da5aa8
Klassen för att kommunicera med API:t.
*/

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'model.dart';

const apiUrl = 'https://todoapp-api-vldfm.ondigitalocean.app';
const apiKey = '8d656188-4d49-475c-92f4-d6ffb2da5aa8';

class ApiTalker {
  //Metod för att hämta listan.
  static Future<List<Todo>> fetchTask() async {
    var response = await http.get('$apiUrl/todos?key=$apiKey');

    var json = jsonDecode(response.body);
    return json.map<Todo>((data) {
      return Todo.fromJson(data);
    }).toList();
  }

  //Metod för att skicka till listan.
  static Future postTask(Todo task) async {
    var json = jsonEncode(Todo.toJson(task));
    await http.post(
      '$apiUrl/todos?key=$apiKey',
      headers: {'Content-Type': 'application/json'},
      body: json,
    );
  }

  //Metod för att ta bort task från listan.
  static Future deleteTask(String taskid) async {
    await http.delete('$apiUrl/todos/$taskid?key=$apiKey');
  }

  //Metod för att uppdatera listan med done.
  static Future updateDone(Todo task, String taskid) async {
    var json = jsonEncode(Todo.toJson(task));
    await http.put(
      '$apiUrl/todos/$taskid?key=$apiKey',
      headers: {'Content-Type': 'application/json'},
      body: json,
    );
  }
}
