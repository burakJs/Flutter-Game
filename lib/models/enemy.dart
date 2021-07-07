import 'package:flutter/material.dart';

class Enemy {
  double top;
  int leftOrRight;
  IconData icon;
  bool isDied;

  Enemy({
    required this.top,
    required this.leftOrRight,
    required this.icon,
    required this.isDied,
  });

  void update() {
    top += 10;
    checkDied();
  }

  void checkDied() {
    isDied = top > 500;
  }
}
