import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/models/student.dart';
import 'package:flutter_hive_demo/pages/add_student_screen.dart';
import 'package:hive/hive.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  late Box<Student> studentBox;

  @override
  void initState() {
    super.initState();

    studentBox = Hive.box('student');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          final student = studentBox.getAt(index) as Student;

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student.id.toString()),
                  Text(student.name.toString()),
                  Text(student.age.toString()),
                  Text(student.subject.toString()),
                ],
              ),
            ),
          );
        },
        itemCount: studentBox.length,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddStudentScreen();
          }));
        },
        label: const Text('追加'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
