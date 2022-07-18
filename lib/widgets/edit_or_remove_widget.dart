import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class EditOrRemoveWidget extends StatelessWidget {
  const EditOrRemoveWidget({
    Key? key,
    required this.label,
    this.icon,
  }) : super(key: key);

  final String label;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: 15,
              left: 15,
            ),
            child: Text(
              label,
              style: kSemibold.copyWith(
                fontSize: 13,
              ),
            ),
          ),
          Container(
            child: icon,
          ),
        ],
      ),
    );
  }
}
