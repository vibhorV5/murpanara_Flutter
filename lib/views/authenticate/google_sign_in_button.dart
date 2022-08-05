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
      height: _mediaQuery.size.height * 0.07,
      width: _mediaQuery.size.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            margin: EdgeInsets.only(
              left: constraints.maxWidth * 0.1,
              right: constraints.maxWidth * 0.1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(constraints.maxHeight * 0.9),
              color: kColorGoogleButton,
            ),
            child: TextButton(
              style: kButtonStyleGoogle,
              onPressed: () async {
                dynamic result = await AuthService().googleSignIn();
                if (result == null) {
                  setState(() {
                    error = 'Check Internet Connection & Try Again';
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
                    fontSize: constraints.maxHeight * 0.34),
              ),
            ),
          );
        },
      ),
    );
  }
}
