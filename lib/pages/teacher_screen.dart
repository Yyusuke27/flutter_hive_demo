import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/models/teacher.dart';
import 'package:flutter_hive_demo/pages/add_teacher_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  late Box<Teacher> teacherBox;

  @override
  void initState() {
    super.initState();

    teacherBox = Hive.box('teachers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: teacherBox.listenable(),
        builder: (context, box, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final teacher = teacherBox.getAt(index) as Teacher;

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(teacher.id.toString()),
                      Text(teacher.name.toString()),
                      Text(teacher.age.toString()),
                      Text(teacher.subject.toString()),
                    ],
                  ),
                ),
              );
            },
            itemCount: teacherBox.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddTeacherScreen();
          }));
        },
        label: const Text('追加'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
