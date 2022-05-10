import 'package:flutter/material.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/authenticate/authenticate_page.dart';
import 'package:murpanara/views/main%20page/main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomCircular();
        } else if (snapshot.hasError) {
          return ErrorW();
        } else if (snapshot.hasData) {
          // Navigator.pop(context);
          return MainPage();
        } else {
          return AuthenticatePage();
        }
      },
    );
  }
}

class CustomCircular extends StatelessWidget {
  const CustomCircular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ErrorW extends StatelessWidget {
  const ErrorW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Error'),
    );
  }
}
