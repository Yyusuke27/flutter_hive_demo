import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/pages/bank_screen.dart';
import 'package:flutter_hive_demo/pages/home_screen.dart';
import 'package:flutter_hive_demo/pages/student_screen.dart';
import 'package:flutter_hive_demo/pages/teacher_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.initFlutter('hive_db');
  // initFlutter()を使うことで以下の処理を内部的にやってくれている
  // final Directory appDir = await getApplicationDocumentsDirectory();
  // Hive.init(appDir.path);

  await Hive.openBox('home');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Hive'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  final pages = <Widget>[
    HomeScreen(),
    StudentScreen(),
    TeacherScreen(),
    BankScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.tealAccent,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: 'Student'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: 'Teacher'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.money_outlined,
              ),
              label: 'Bank'),
        ],
      ),
    );
  }
}
