import 'package:flutter/material.dart';

class InHandToken extends StatelessWidget {
  const InHandToken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        width: 30,
        color: Colors.green,
      ),
    );
  }
}
