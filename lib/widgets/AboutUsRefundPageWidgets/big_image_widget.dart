import 'package:flutter/material.dart';

class BigImageWidget extends StatelessWidget {
  const BigImageWidget({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
  }) : super(key: key);

  final String imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.pink,
      height: height,
      width: width,
      child: Image.asset(imageUrl),
    );
  }
}
