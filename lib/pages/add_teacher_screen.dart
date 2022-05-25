import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/models/teacher.dart';
import 'package:hive/hive.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({Key? key}) : super(key: key);

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  // validationのために必要
  final _key = GlobalKey<FormState>();
  int id = 0;
  String? name;
  int age = 0;
  String? subject;

  late Box<Teacher> teacherBox;

  @override
  void initState() {
    super.initState();

    teacherBox = Hive.box('teachers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('生徒追加ページ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Id',
                      helperText: 'idを入力してください。',
                    ),
                    onSaved: (value) {
                      id = int.parse(value.toString());
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: '氏名',
                      helperText: '氏名を入力してください。',
                    ),
                    onSaved: (value) {
                      name = value.toString();
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '年齢',
                      helperText: '年齢を入力してください。',
                    ),
                    onSaved: (value) {
                      age = int.parse(value.toString());
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: '教科',
                      helperText: '教科を入力してください。',
                    ),
                    onSaved: (value) {
                      subject = value.toString();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          saveTeacher();
        },
        label: const Text('保存'),
        icon: const Icon(Icons.save),
      ),
    );
  }

  void saveTeacher() {
    final isValid = _key.currentState?.validate();

    if (isValid != null && isValid) {
      _key.currentState?.save();
      teacherBox.add(
        Teacher(
          id: id,
          name: name.toString(),
          age: age,
          subject: subject.toString(),
        ),
      );
    }
  }
}
