import 'package:flutter_hive_demo/models/bank.dart';
import 'package:flutter_hive_demo/models/student.dart';
import 'package:flutter_hive_demo/models/teacher.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:path_provider/path_provider.dart';

class Initializer {
  static Future<void> execute() async {
    await Hive.initFlutter('hive_db');
    // initFlutter()を使うことで以下の処理を内部的にやってくれている
    // final Directory appDir = await getApplicationDocumentsDirectory();
    // Hive.init(appDir.path);

    Hive.registerAdapter<Student>(StudentAdapter());
    Hive.registerAdapter<Teacher>(TeacherAdapter());
    Hive.registerAdapter<Bank>(BankAdapter());

    await Hive.openBox('home');
    await Hive.openBox<Student>('student');
    await Hive.openBox<Teacher>('teachers');
    await Hive.openBox<Bank>('banks');
  }
}
