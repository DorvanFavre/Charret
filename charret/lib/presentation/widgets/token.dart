import 'package:flutter/material.dart';

class Token extends StatelessWidget {
  final int value;
  const Token({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: value == 1
          ? Colors.red
          : value == 2
              ? Colors.blue
              : Colors.grey,
    );
  }
}
