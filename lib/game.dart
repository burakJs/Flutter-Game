import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game/game_over.dart';
import 'package:game/models/enemy.dart';
import 'package:kartal/kartal.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  var point = 0;
  List<Enemy> enemyArray = [];

  var TIME = 1000 ~/ 30;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    print('ZAMAN : $TIME');
    timer = Timer.periodic(Duration(milliseconds: TIME), (timer) => gameUpdate(timer.tick));
  }

  void gameUpdate(int time) {
    if (time % 30 == 0) {
      var enemy = generateEnemy();
      enemyArray.add(enemy);
    }
    if (time % 100 == 0 && TIME > 15) {
      TIME -= 5;
      timer.cancel();
      startGame();
    }
    enemyArray.map((e) => e.update());
    for (var enemy in enemyArray) {
      // if (enemy.isDied) {
      //   timer.cancel();
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => GameOverView(
      //                 point: point,
      //               )),
      //       (route) => false);
      // }
      enemy.update();
    }
    setState(() {});
  }

  Enemy generateEnemy() {
    var pos = Random().nextInt(2);

    return Enemy(top: 0, leftOrRight: pos, icon: pos == 0 ? Icons.arrow_left : Icons.arrow_right, isDied: false);
  }

  void checkButton(int checkNum) {
    if (enemyArray.isEmpty) {
      return;
    }
    if (checkNum == enemyArray.first.leftOrRight) {
      enemyArray.removeAt(0);
      point += 100;
    } else {
      point -= 10;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Game',
          style: context.textTheme.headline4!.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: enemyArray.map((e) => buildPositionedEnemy(e, context)).toList(),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildGestureDetectorButton(0),
                Text(
                  '$point',
                  style: context.textTheme.headline3!.copyWith(color: Colors.white),
                ),
                buildGestureDetectorButton(1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildGestureDetectorButton(int checkNum) {
    return GestureDetector(
      onTap: () => checkButton(checkNum),
      child: CircleAvatar(
        child: Icon(checkNum == 0 ? Icons.arrow_left : Icons.arrow_right),
        radius: 36,
      ),
    );
  }

  Positioned buildPositionedEnemy(Enemy e, BuildContext context) {
    return Positioned(
      top: e.top,
      right: e.leftOrRight == 1 ? 0 : context.width - 72,
      left: e.leftOrRight == 0 ? 0 : context.width - 72,
      child: CircleAvatar(
        radius: 36,
        backgroundColor: Colors.red,
        child: Icon(
          e.icon,
          size: 32,
        ),
      ),
    );
  }
}
