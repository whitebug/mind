import 'package:flutter/material.dart';
import 'package:mind/screens/screens.dart';

void main() => runApp(Mindfulness());

class Mindfulness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindfulness',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PlayerScreen(),
    );
  }
}
