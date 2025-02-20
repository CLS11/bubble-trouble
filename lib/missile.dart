import 'package:flutter/material.dart';

class Missile extends StatelessWidget {
  const Missile({
    required this.missileX,
    required this.missileY,
    required this.missileHeight,
    super.key,
  });

  final double missileX;
  final double missileY;
  final double missileHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX, missileY),
      child: Container(
        width: 2, 
        height: missileHeight, 
        color: Colors.grey,
        ),
    );
  }
}
