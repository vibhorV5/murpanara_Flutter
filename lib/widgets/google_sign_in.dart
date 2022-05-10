import 'package:flutter/material.dart';
import 'package:murpanara/services/auth.dart';

class GoogleSignIn extends StatefulWidget {
  GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  @override
  Widget build(BuildContext context) {
    String error = '';

    return Container(
      width: 400,
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      margin: const EdgeInsets.only(left: 40, right: 40, top: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFFEA4335),
      ),
      child: TextButton(
        style: const ButtonStyle(
          splashFactory: NoSplash.splashFactory,
        ),
        onPressed: () async {
          dynamic result = await AuthService().googleSignIn();
          if (result == null) {
            setState(() {
              error = 'Google Error';
            });
          }
        },
        child: const Text(
          'Google Sign In',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
