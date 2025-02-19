import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({required this.icon, super.key, this.function});
  final IconData icon;
  final dynamic function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function as GestureTapCallback,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
          ),
          width: 50,
          height: 50,
          child: Icon(icon),
        ),
      ),
    );
  }
}
