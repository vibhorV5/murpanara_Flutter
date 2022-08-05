import 'package:flutter/material.dart';

class CustomFavButton extends StatelessWidget {
  const CustomFavButton({
    Key? key,
    required this.icon,
    required this.borderRadiusGeometry,
    required this.containerHeight,
    required this.containerWidth,
  }) : super(key: key);

  final Widget? icon;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final double containerHeight;
  final double containerWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
        color: const Color(0xFFF6F6F6),
        borderRadius: borderRadiusGeometry,
      ),
      child: icon,
    );
  }
}
