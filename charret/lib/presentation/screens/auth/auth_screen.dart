import 'package:charret/application/states/noUserLoggedIn/no_user_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerRepeatPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<NoUserLoggedIn>();

    // Presentation to application
    loginEmailController.addListener(() {
      state.loginEmail = loginEmailController.text;
    });

    loginPasswordController.addListener(() {
      state.loginPassword = loginPasswordController.text;
    });

    registerEmailController.addListener(() {
      state.registerEmail = registerEmailController.text;
    });

    registerPasswordController.addListener(() {
      state.registerPassword = registerPasswordController.text;
    });

    registerRepeatPasswordController.addListener(() {
      state.registerRepeatPassword = registerRepeatPasswordController.text;
    });
  }

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerRepeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<NoUserLoggedIn>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                isLogin ? 'Login' : 'Register',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 50,
              ),

              //Text Fields

              Column(
                mainAxisSize: MainAxisSize.min,
                children: isLogin
                    ? [
                        AuthField(
                          hintText: 'Email',
                          controller: loginEmailController,
                        ),
                        AuthField(
                          hintText: 'Password',
                          controller: loginPasswordController,
                          obscure: true,
                        )
                      ]
                    : [
                        AuthField(
                          hintText: 'Email',
                          controller: registerEmailController,
                        ),
                        AuthField(
                          hintText: 'Password',
                          controller: registerPasswordController,
                          obscure: true,
                        ),
                        AuthField(
                          hintText: 'Repeat Password',
                          controller: registerRepeatPasswordController,
                          obscure: true,
                        )
                      ],
              ),

              Spacer(),

              // Login / register button
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(isLogin
                        ? "Je n'ai pas de compte   "
                        : "J'ai déja un compte   "),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          isLogin ? "s'enregistrer" : "se connecter",
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  child: Text(isLogin ? 'Login' : 'Register'),
                  onPressed: isLogin
                      ? () {
                          state.login();
                        }
                      : () {
                          state.register();
                        },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AuthField extends StatelessWidget {
  final bool obscure;
  final String hintText;
  final TextEditingController controller;
  const AuthField(
      {required this.hintText,
      required this.controller,
      this.obscure = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
