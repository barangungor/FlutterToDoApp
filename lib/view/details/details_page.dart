import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/repo/todo/todo_repo.dart';
import 'package:todoapp/view/base/appbar.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var arg;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        arg = ModalRoute.of(context)!.settings.arguments;
        arg = arg['data'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final todoRepo = Provider.of<ToDoRepo>(context);
    return Scaffold(
      appBar: appBar(context, true),
      floatingActionButton: arg != null
          ? FloatingActionButton(
              backgroundColor: todoRepo.todos
                          ?.where((element) => element['id'] == arg['id'])
                          .first['isDeleted'] ==
                      true
                  ? Colors.red
                  : Colors.blue,
              child: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  todoRepo.todos
                          ?.where((element) => element['id'] == arg['id'])
                          .first['isDeleted'] =
                      !todoRepo.todos
                          ?.where((element) => element['id'] == arg['id'])
                          .first['isDeleted'];
                });
                todoRepo.saveDataToPref();
              })
          : null,
      body: Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          title: const Text("Başlık"),
          subtitle: Text(arg?['title'] ?? "Bulunamadı"),
        ),
        ListTile(
          title: const Text("Durumu"),
          subtitle:
              Text(arg?['completed'] == true ? "Tamamlandı" : "Tamamlanmadı"),
        ),
        ListTile(
          title: const Text("User Id"),
          subtitle: Text(arg?['userId'].toString() ?? "Bulunamadı"),
        ),
      ])),
    );
  }
}
