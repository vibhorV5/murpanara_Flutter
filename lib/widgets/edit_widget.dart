import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class EditWidget extends StatelessWidget {
  const EditWidget({
    Key? key,
  }) : super(key: key);

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
              'Edit ',
              style: kSemibold.copyWith(
                fontSize: 13,
              ),
            ),
          ),
          Icon(
            Icons.edit,
            size: 14,
          ),
        ],
      ),
    );
  }
}
