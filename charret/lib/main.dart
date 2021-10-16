import 'package:charret/application/states/app/app.dart';
import 'package:charret/presentation/wrappers/appState/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final app = App();

  runApp(Provider.value(
    value: app,
    builder: (context, _) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charret',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: AppStateWrapper()),
    );
  }
}
