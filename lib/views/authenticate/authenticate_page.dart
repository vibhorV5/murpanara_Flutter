import 'package:flutter/material.dart';
import 'package:murpanara/views/authenticate/register.dart';
import 'package:murpanara/views/authenticate/sign_in.dart';

class AuthenticatePage extends StatefulWidget {
  const AuthenticatePage({Key? key}) : super(key: key);

  @override
  State<AuthenticatePage> createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  bool showRegisterPage = true;

  @override
  Widget build(BuildContext context) {
    if (showRegisterPage) {
      return Register(toggleView: toggleView);
    } else {
      return SignIn(toggleView: toggleView);
    }
  }

  void toggleView() {
    setState(() {
      showRegisterPage = !showRegisterPage;
    });
  }
}
