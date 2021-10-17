import 'package:charret/application/states/userLoggedIn/user_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userLoggedInState = context.read<UserLoggedIn>();

    return Center(
        child: ElevatedButton(
      child: const Text('Logout'),
      onPressed: () {
        userLoggedInState.logout();
      },
    ));
  }
}
