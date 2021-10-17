import 'package:charret/presentation/wrappers/appState/app_state_wrapper.dart';
import 'package:flutter/material.dart';

class GlobalMessageWrapper extends StatefulWidget {
  const GlobalMessageWrapper({Key? key}) : super(key: key);

  @override
  State<GlobalMessageWrapper> createState() => _GlobalMessageWrapperState();
}

class _GlobalMessageWrapperState extends State<GlobalMessageWrapper> {
  @override
  Widget build(BuildContext context) {
    return AppStateWrapper();
  }
}
