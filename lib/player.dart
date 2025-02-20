import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  const Player({required this.playerX, super.key});
  final double playerX;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX, 1),
      child: SizedBox(
        width: 150,
        height: 150,
        child: Image.asset(
          'images/rabbit_wo.png', 
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
