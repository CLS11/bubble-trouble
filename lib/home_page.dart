// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/ball.dart';
import 'package:myapp/button.dart';
import 'package:myapp/missile.dart';
import 'package:myapp/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//Enum for directions
enum directions { LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  //Alignment variables
  static double playerX = 0;

  //Missile variables
  double missileX = playerX;
  double missileY = 0;
  double missileHeight = 0;
  bool midShot = false;

  //Converting the height to the co-ordinate
  double heightToPosition(double height) {
    final totalHeight = MediaQuery.of(context).size.height;
    final position = 1 - (2 * (height / totalHeight));
    return position;
  }

  //Ball variables
  double ballX = 0.5;
  double ballY = 0;
  var ballDirection = directions.LEFT;

  //Methods for the movement
  void startGame() {
    double time = 0;
    double height = 0;
    double velocity = 60;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = -5 + time * time + velocity * time;
      if (height < 0) {
        time = 0;
      }
      setState(() {
        ballY = heightToPosition(height);
      });
      if (ballX - 0.005 < -1) {
        ballDirection = directions.RIGHT;
      } else if (ballX + 0.005 > 1) {
        ballDirection = directions.LEFT;
      }
      if (ballDirection == directions.LEFT) {
        setState(() {
          ballX -= 0.005;
        });
      } else {
        setState(() {
          ballX += 0.005;
        });
      }
      if (playerDies()) {
        timer.cancel();
        _showDialog();
      }
      time += 0.1;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[700],
          title: const Text('DEAD!', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }

  void moveLeft() {
    setState(() {
      if (playerX - 0.1 < -1) {
        return;
      } else {
        playerX -= 0.1;
      }
      missileX = playerX;
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + 0.1 > 1) {
        return;
      } else {
        playerX += 0.1;
      }
      if (!midShot) {
        missileX = playerX;
      }
    });
  }

  void fireMissile() {
    if (midShot == false) {
      Timer.periodic(const Duration(milliseconds: 20), (timer) {
        midShot = true;
        setState(() {
          missileHeight += 10;
          missileY = heightToPosition(missileHeight);
        });
        if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
          resetMissile();
          timer.cancel();
        }
        if (ballY > heightToPosition(missileHeight) &&
            (ballX - missileX).abs() < 0.03) {
          resetMissile();
          ballX = 5;
          timer.cancel();
        }
      });
    }
  }

  void resetMissile() {
    missileX = playerX;
    missileY = heightToPosition(0);
    missileHeight = 0;
    midShot = false;
  }

  bool playerDies() {
    if ((ballX - playerX).abs() < 0.05 && ballY > 0.95) {
      return true;
    } else {
      return false;
    }
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
                      //Missile
                      Missile(
                        missileX: missileX,
                        missileY: missileY,
                        missileHeight: missileHeight,
                      ),
                      //Player
                      Player(playerX: playerX),
                      //Ball
                      Ball(ballX: ballX, ballY: ballY),
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
                    Button(icon: Icons.play_arrow, function: startGame),
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
