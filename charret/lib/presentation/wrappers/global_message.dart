import 'package:charret/application/global_message/global_message.dart';
import 'package:charret/application/models/result.dart';
import 'package:charret/presentation/wrappers/appState/app_state_wrapper.dart';
import 'package:flutter/material.dart';

class GlobalMessageWrapper extends StatefulWidget {
  const GlobalMessageWrapper({Key? key}) : super(key: key);

  @override
  State<GlobalMessageWrapper> createState() => _GlobalMessageWrapperState();
}

class _GlobalMessageWrapperState extends State<GlobalMessageWrapper> {
  @override
  void initState() {
    super.initState();

    GlobalMessage().messageStream.listen((result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result.message),
        backgroundColor:
            result is Success ? Theme.of(context).primaryColor : Colors.red,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AppStateWrapper();
  }
}
