import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  const Player({required this.playerX, super.key});
  final double playerX;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX, 1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepPurple,
        ),
        width: 50,
        height: 50,
      ),
    );
  }
}
