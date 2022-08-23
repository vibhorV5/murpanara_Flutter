import 'package:flutter/material.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/authenticate/authenticate_page.dart';
import 'package:murpanara/views/main_page/main_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomCircular();
        } else if (snapshot.hasError) {
          return const ErrorW();
        } else if (snapshot.hasData) {
          return const MainPage();
        } else {
          return const AuthenticatePage();
        }
      },
    );
  }
}

class CustomCircular extends StatelessWidget {
  const CustomCircular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}

class ErrorW extends StatelessWidget {
  const ErrorW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Error'),
    );
  }
}
