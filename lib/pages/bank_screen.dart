import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/models/bank.dart';
import 'package:flutter_hive_demo/pages/add_bank_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({Key? key}) : super(key: key);

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  late Box<Bank> bankBox;

  @override
  void initState() {
    super.initState();

    bankBox = Hive.box('banks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: bankBox.listenable(),
        builder: (context, box, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final bank = bankBox.getAt(index) as Bank;

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bank.id.toString()),
                      Text(bank.name.toString()),
                      Text(bank.accountNumber.toString()),
                      Text(bank.amount.toString()),
                    ],
                  ),
                ),
              );
            },
            itemCount: bankBox.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddBankScreen();
          }));
        },
        label: const Text('追加'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
