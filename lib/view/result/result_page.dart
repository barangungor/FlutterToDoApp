import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/repo/todo/todo_repo.dart';
import 'package:todoapp/view/base/appbar.dart';
import 'package:todoapp/view/globalComponents/global_components.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List? resultData;
  @override
  void initState() {
    super.initState();
    resultData = context
        .read<ToDoRepo>()
        .todos!
        .where((element) => element['completed'] == true)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final todoRepo = Provider.of<ToDoRepo>(context);
    return Scaffold(
      appBar: appBar(context, true, actionButtons: [
        PopupMenuButton(
            icon: const Icon(Icons.filter_alt),
            onSelected: (value) {
              setState(() {
                switch (value) {
                  case 1:
                    resultData = context
                        .read<ToDoRepo>()
                        .todos!
                        .where((element) => element['completed'] == true)
                        .toList();
                    break;
                  case 2:
                    resultData = context
                        .read<ToDoRepo>()
                        .todos!
                        .where((element) => element['completed'] == false)
                        .toList();
                    break;
                  case 3:
                    resultData = context.read<ToDoRepo>().todos;
                    break;
                  default:
                }
              });
            },
            itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text("Tamamlananlar"),
                    value: 1,
                  ),
                  const PopupMenuItem(
                    child: Text("Tamamlanmayanlar"),
                    value: 2,
                  ),
                  const PopupMenuItem(
                    child: Text("Hepsi"),
                    value: 3,
                  )
                ])
      ]),
      body: ListView.builder(
        itemCount: resultData?.length,
        itemBuilder: (BuildContext context, int index) {
          final data = resultData?[index];
          return todoCard(context, todoRepo, data, index, setState);
        },
      ),
    );
  }
}
