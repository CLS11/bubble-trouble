// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/button.dart';
import 'package:myapp/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Alignment variables
  double playerX = 0;
  //Missile variables
  double missileX = 0;
  double missileY = 0;
  double missileHeight = 0;
  //Methods for the movement
  void moveLeft() {
    setState(() {
      if (playerX - 0.1 < -1) {
        return;
      } else {
        playerX -= 0.1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + 0.1 > 1) {
        return;
      } else {
        playerX += 0.1;
      }
    });
  }

  void fireMissile() {
    Timer.periodic(Duration(milliseconds: 20), (timer) {
      setState(() {
        missileHeight += 10;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            moveLeft();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            moveRight();
          } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
            fireMissile();
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.pink[100],
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment(missileX, missileY),
                        child: Container(
                          width: 5,
                          height: missileHeight,
                          color: Colors.grey,
                        ),
                      ),
                      Player(playerX: playerX),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(icon: Icons.arrow_back, function: moveLeft),
                    Button(icon: Icons.arrow_forward, function: moveRight),
                    Button(icon: Icons.arrow_upward, function: fireMissile),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
