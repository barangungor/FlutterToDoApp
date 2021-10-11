import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:todoapp/controller/network/network.dart';
import 'package:todoapp/global/global_datas.dart';

class ToDoRepo with ChangeNotifier {
  List? todos;

  Future getToDoList() async {
    await NetworkController()
        .get('https://jsonplaceholder.typicode.com/todos')
        .then((value) {
      List? compareData =
          json.decode(preferences!.getString('todoList').toString());
      if (compareData != null) {
        todos = compareData;
      } else {
        todos = json.decode(value);
        todos?.forEach((element) {
          element['isDeleted'] = false;
        });
      }
    });
  }

  Future saveDataToPref() async {
    preferences?.setString('todoList', json.encode(todos));
  }
}
