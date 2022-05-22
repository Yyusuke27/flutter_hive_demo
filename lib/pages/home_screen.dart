import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box homeBox;

  @override
  void initState() {
    super.initState();

    homeBox = Hive.box('home');
    homeBox.put('1', 'Taro');
    homeBox.put('2', 'Hanako');
    homeBox.put('3', 'Jiro');
    homeBox.putAll({
      '4': 'Tanaka',
      '5': 'Yamada',
      '6': 'Yoshida',
    });

    homeBox.add('Sato');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(homeBox.get('1')),
        Text(homeBox.get('2')),
        Text(homeBox.get('3')),
        Text(homeBox.get('4')),
        Text(homeBox.get('5')),
        Text(homeBox.get('6')),
      ],
    );
  }
}
