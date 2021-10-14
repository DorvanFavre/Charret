import 'package:charret/application/app_state_machine/app_state.dart';
import 'package:charret/application/app_state_machine/loading.dart';
import 'package:charret/application/state_machine/state_machine_impl.dart';
import 'package:charret/presentation/wrappers/appState/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application/app_state_machine/ready.dart';

void main() {
  final appStateMachine = StateMachineImpl<AppState>(initialState: Loading());

  runApp(Provider.value(
    value: appStateMachine,
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
