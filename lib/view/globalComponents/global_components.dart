import 'package:flutter/material.dart';
import 'package:todoapp/controller/navigation/navigation.dart';
import 'package:todoapp/repo/todo/todo_repo.dart';

Card todoCard(BuildContext context, ToDoRepo todoRepo, data, index,
    StateSetter setState) {
  return Card(
    child: Row(children: [
      Checkbox(
        value: data['completed'],
        onChanged: (value) => setState(() {
          todoRepo.todos?[index]['completed'] = value;
          todoRepo.saveDataToPref();
        }),
      ),
      Expanded(
        child: ListTile(
          onTap: () => NavigationController()
              .goWithData(context, '/detail', {'data': data}).then((value) {
            setState(() {});
          }),
          title: Text(data['title']),
          subtitle: data['isDeleted'] == true ? const Text("Silindi") : null,
        ),
      ),
    ]),
  );
}
