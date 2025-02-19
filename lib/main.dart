import 'package:flutter/material.dart';
import 'package:myapp/home_page.dart';

void main() {
  runApp(const BubbleTrouble());
}

class BubbleTrouble extends StatelessWidget {
  const BubbleTrouble({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
