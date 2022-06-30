import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/services/auth.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    String error = '';

    return SizedBox(
      // color: Colors.blue.withOpacity(0.3),
      height: _mediaQuery.size.height * 0.24,
      width: _mediaQuery.size.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            padding: EdgeInsets.only(
                top: constraints.maxHeight * 0.01,
                bottom: constraints.maxHeight * 0.01),
            margin: EdgeInsets.only(
                left: constraints.maxWidth * 0.1,
                right: constraints.maxWidth * 0.1,
                top: constraints.maxHeight * 0.69),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(constraints.maxHeight * 0.2),
              color: kColorGoogleButton,
            ),
            child: TextButton(
              style: kButtonStyleGoogle,
              onPressed: () async {
                dynamic result = await AuthService().googleSignIn();
                if (result == null) {
                  setState(() {
                    error = 'Check Internet Connection & Try Again.';
                  });
                  final SnackBar errorSnackBar = SnackBar(
                    elevation: 10,
                    backgroundColor: kColorSnackBarBackgroundAuthPage,
                    content: Text(
                      error,
                      style: kSnackBarTextStyleAuthPage,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                }
              },
              child: Text(
                'Google Sign In',
                style: kGoogleButtonTextStyle.copyWith(
                    fontSize: constraints.maxHeight * 0.12),
              ),
            ),
          );
        },
      ),
    );
  }
}