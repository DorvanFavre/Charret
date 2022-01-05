import 'package:charret/application/states/userLoggedIn/user_logged_in.dart';
import 'package:charret/presentation/screens/menu/rules_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userLoggedInState = context.read<UserLoggedIn>();

    return Scaffold(
      // App bar
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => RulesScreen()));
            },
            icon: const FaIcon(FontAwesomeIcons.book),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: ElevatedButton(
                          child: const Text('Logout'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            userLoggedInState.logout();
                          },
                        )),
                  ),
                );
              },
              icon: const FaIcon(FontAwesomeIcons.cog))
        ],
      ),

      // Body
      body: Center(
          child: ElevatedButton(
        child: const Text('Search game'),
        onPressed: () {
          userLoggedInState.searchGame();
        },
      )),
    );
  }
}
