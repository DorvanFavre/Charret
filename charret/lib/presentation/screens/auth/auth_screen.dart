import 'package:charret/application/states/noUserLoggedIn/no_user_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
            onPressed: () {
              context.read<NoUserLoggedIn>().login();
            },
            child: const Text('Login')));
  }
}
