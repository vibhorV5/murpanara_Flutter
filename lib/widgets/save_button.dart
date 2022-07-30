import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.mediaQuery,
    required this.txt,
    required this.color,
    required this.txtColor,
    required this.onPress,
  }) : super(key: key);

  final MediaQueryData mediaQuery;
  final String txt;
  final Color color;
  final Color txtColor;

  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: onPress,
      child: Container(
        margin: EdgeInsets.only(
            // top: _mediaQuery.size.height * 0.01,
            // bottom: _mediaQuery.size.height * 0.02,
            ),
        alignment: Alignment.center,
        height: mediaQuery.size.height * 0.06,
        width: mediaQuery.size.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(mediaQuery.size.height * 0.4),
        ),
        // color: Colors.amber,
        child: Text(
          txt,
          style: kAddToCartTextStyle.copyWith(
              color: txtColor, fontSize: mediaQuery.size.height * 0.02),
        ),
      ),
    );
  }
}
