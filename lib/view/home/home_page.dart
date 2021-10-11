import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/navigation/navigation.dart';
import 'package:todoapp/repo/todo/todo_repo.dart';
import 'package:todoapp/view/base/appbar.dart';
import 'package:todoapp/view/globalComponents/global_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future? getTodos;
  @override
  void initState() {
    super.initState();
    getTodos = context.read<ToDoRepo>().getToDoList();
  }

  @override
  Widget build(BuildContext context) {
    final todoRepo = Provider.of<ToDoRepo>(context);
    return Scaffold(
      appBar: appBar(context, false, actionButtons: [
        Stack(children: [
          IconButton(
              onPressed: () {
                NavigationController()
                    .go(context, '/result')
                    .then((value) => setState(() {}));
              },
              icon: const Icon(Icons.list)),
          Positioned(
              right: 5,
              top: 5,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.025,
                  width: MediaQuery.of(context).size.height * 0.025,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Text(
                    todoRepo.todos
                            ?.where((element) => element['completed'] == true)
                            .toList()
                            .length
                            .toString() ??
                        "",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.025),
                  ))))
        ])
      ]),
      body: FutureBuilder(
        future: getTodos,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SizedBox(
                    width: 15, height: 15, child: CircularProgressIndicator()));
          } else if (snapshot.data.toString().isEmpty) {
            return const Center(child: Text("Boş"));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: todoRepo.todos?.length,
              itemBuilder: (BuildContext context, int index) {
                final data = todoRepo.todos?[index];
                return todoCard(context, todoRepo, data, index, setState);
              },
            );
          }
        },
      ),
    );
  }
}
