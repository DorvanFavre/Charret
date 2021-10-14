import 'package:charret/application/app_state_machine/app_state.dart';
import 'package:charret/application/app_state_machine/loading.dart';
import 'package:charret/application/app_state_machine/ready.dart';
import 'package:charret/application/state_machine/state_machine_impl.dart';
import 'package:charret/presentation/screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppStateWrapper extends StatelessWidget {
  const AppStateWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppState>(
        stream: context.read<StateMachineImpl<AppState>>().state,
        builder: (context, snap) {
          final state = snap.data;
          if (state is Loading) {
            return const LoadingScreen();
          }
          if (state is Ready) {
            return const Center(
              child: Text('READYY'),
            );
          }
          return const Center(
            child: Text('ERROR'),
          );
        });
  }
}
