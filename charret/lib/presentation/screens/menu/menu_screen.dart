import 'package:charret/application/models/data_user.dart';
import 'package:charret/application/states/userLoggedIn/user_logged_in.dart';
import 'package:charret/presentation/screens/menu/rules_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController nameController =
      TextEditingController(text: 'Unknown');

  String lastName = '';

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final userLoggedInState = context.read<UserLoggedIn>();

    userLoggedInState.getDataUserStream().listen((event) {
      nameController.text = event.name;
    });

    super.initState();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // User data

            TextFormField(
              controller: nameController,
              style: Theme.of(context).textTheme.headline3,
            ),

            Center(
              child: Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Button
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Search game'),
              ),
              onPressed: () {
                userLoggedInState.setUserName(nameController.text);
                userLoggedInState.searchGame();
              },
            ),

            //Text('Powered by Dorvan')
          ],
        ),
      ),
    );
  }
}
