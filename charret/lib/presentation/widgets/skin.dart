import 'package:flutter/material.dart';

class Skin extends StatelessWidget {
  final bool isCurrentPlayer;
  const Skin({Key? key, required this.isCurrentPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentPlayer ? Colors.blue : Colors.red,
        shape: BoxShape.circle,
      ),
    );
  }
}
