/* 
Min lista,
https://todoapp-api-vldfm.ondigitalocean.app/todos?key=8d656188-4d49-475c-92f4-d6ffb2da5aa8
Klassen för att kommunicera med API:t
*/

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';
import 'dart:async';

const API_URL = 'https://todoapp-api-vldfm.ondigitalocean.app';
const API_KEY = '8d656188-4d49-475c-92f4-d6ffb2da5aa8';

class APITalker {
  //Metod för att hämta listan
  static Future<List<Todo>> fetchTask() async {
    var response = await http.get('$API_URL/todos?key=$API_KEY');

    var json = jsonDecode(response.body);
    return json.map<Todo>((data) {
      return Todo.fromJson(data);
    }).toList();
  }

  //Metod för att skicka till listan
  static Future postTask(Todo task) async {
    var json = jsonEncode(Todo.toJson(task));
    await http.post(
      '$API_URL/todos?key=$API_KEY',
      headers: {'Content-Type': 'application/json'},
      body: json,
    );
  }

  //Metod för att ta bort task från listan
  static Future deleteTask(String taskid) async {
    await http.delete('$API_URL/todos/$taskid?key=$API_KEY');
  }

  //Metod för att uppdatera listan med done
  static Future updateDone(Todo task, String taskid) async {
    var json = jsonEncode(Todo.toJson(task));
    await http.put(
      '$API_URL/todos/$taskid?key=$API_KEY',
      headers: {'Content-Type': 'application/json'},
      body: json,
    );
  }
}
