import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/global/global_datas.dart';
import 'package:todoapp/repo/todo/todo_repo.dart';
import 'package:todoapp/view/details/details_page.dart';
import 'package:todoapp/view/home/home_page.dart';
import 'package:todoapp/view/result/result_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  preferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ToDoRepo>(create: (_) => ToDoRepo()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const HomePage(),
            '/detail': (context) => const DetailsPage(),
            '/result': (context) => const ResultPage()
          }),
    );
  }
}
