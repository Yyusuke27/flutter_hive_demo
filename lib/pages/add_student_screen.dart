import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/models/student.dart';
import 'package:hive/hive.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  // validationのために必要
  final _key = GlobalKey<FormState>();
  int id = 0;
  String? name;
  int age = 0;
  String? subject;

  late Box<Student> studentBox;

  @override
  void initState() {
    super.initState();

    studentBox = Hive.box('student');
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
          saveStudent();
        },
        label: const Text('保存'),
        icon: const Icon(Icons.save),
      ),
    );
  }

  void saveStudent() {
    final isValid = _key.currentState?.validate();

    if (isValid != null && isValid) {
      _key.currentState?.save();

      studentBox.add(
        Student(
          id: id,
          name: name.toString(),
          age: age,
          subject: subject.toString(),
        ),
      );
    }
  }
}
