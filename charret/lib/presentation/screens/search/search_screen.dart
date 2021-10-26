import 'package:charret/application/states/userLoggedIn/user_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userLoggedInState = context.read<UserLoggedIn>();

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Search for another player...',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: 50,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            child: const Text('Abort'),
            onPressed: () {
              userLoggedInState.abortGameSearching();
            },
          ),
        ],
      ),
    ));
  }
}
