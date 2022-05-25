import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/models/bank.dart';
import 'package:hive/hive.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({Key? key}) : super(key: key);

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  // validationのために必要
  final _key = GlobalKey<FormState>();
  int id = 0;
  String? name;
  int accountNumber = 0;
  double amount = 0.0;

  late Box<Bank> bankBox;

  @override
  void initState() {
    super.initState();

    bankBox = Hive.box('banks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('銀行追加ページ'),
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
                      labelText: 'アカウント番号',
                      helperText: 'アカウント番号を入力してください。',
                    ),
                    onSaved: (value) {
                      accountNumber = int.parse(value.toString());
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '額',
                      helperText: '額を入力してください。',
                    ),
                    onSaved: (value) {
                      amount = double.parse(value.toString());
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
          saveBank();
        },
        label: const Text('保存'),
        icon: const Icon(Icons.save),
      ),
    );
  }

  void saveBank() {
    final isValid = _key.currentState?.validate();

    if (isValid != null && isValid) {
      _key.currentState?.save();
      bankBox.add(
        Bank(
          id: id,
          name: name.toString(),
          accountNumber: accountNumber,
          amount: amount,
        ),
      );
    }
  }
}
