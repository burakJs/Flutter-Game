import 'package:flutter/material.dart';
import 'package:game/game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GAME',
      home: GameView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
