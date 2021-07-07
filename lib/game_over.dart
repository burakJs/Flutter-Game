import 'package:flutter/material.dart';
import 'package:game/game.dart';
import 'package:kartal/kartal.dart';

class GameOverView extends StatelessWidget {
  final int point;
  const GameOverView({
    Key? key,
    required this.point,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text(
                '$point',
                style: context.textTheme.headline1,
              ),
            ),
            IconButton(
              color: Colors.red,
              focusColor: Colors.black,
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => GameView()), (route) => false);
              },
              icon: Icon(
                Icons.repeat,
                size: 62,
              ),
            )
          ],
        ),
      ),
    );
  }
}
