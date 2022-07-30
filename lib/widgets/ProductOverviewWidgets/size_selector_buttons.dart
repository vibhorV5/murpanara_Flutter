import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/providers/size_provider.dart';
import 'package:provider/provider.dart';

class SizeSelectorButtons extends StatefulWidget {
  const SizeSelectorButtons({
    Key? key,
    required this.mediaQ,
    required this.sizeList,
    required this.productStatus,
  }) : super(key: key);

  final MediaQueryData mediaQ;
  final List sizeList;
  final String selectedS = '';
  final String productStatus;

  @override
  State<SizeSelectorButtons> createState() => _SizeButtonsState();
}

class _SizeButtonsState extends State<SizeSelectorButtons> {
  @override
  Widget build(BuildContext context) {
    var sizeState = Provider.of<SizeProvider>(context);

    return Container(
      margin: EdgeInsets.only(
          left: widget.mediaQ.size.width * 0.055,
          top: widget.mediaQ.size.height * 0.012),
      width: widget.mediaQ.size.width,
      height: widget.mediaQ.size.height * 0.08,
      // color: Colors.yellow.withOpacity(0.3),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: widget.mediaQ.size.width * 0.025,
          );
        },
        itemCount: widget.sizeList.length,
        itemBuilder: ((context, index) {
          Container getContainer;

          if (sizeState.getSizeSelected == widget.sizeList[index]) {
            getContainer = Container(
              alignment: Alignment.center,
              height: widget.mediaQ.size.height * 0.07,
              width: widget.mediaQ.size.width * 0.14,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius:
                    BorderRadius.circular(widget.mediaQ.size.height * 0.01),
              ),
              child: Text(
                widget.sizeList[index],
                style: kProductsSizesTextStyle.copyWith(
                    color: const Color(0xFFF6F6F6),
                    fontFamily: 'AvertaStd-Semibold',
                    fontSize: widget.mediaQ.size.height * 0.028),
              ),
            );
          } else {
            getContainer = Container(
              alignment: Alignment.center,
              height: widget.mediaQ.size.height * 0.07,
              width: widget.mediaQ.size.width * 0.14,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius:
                    BorderRadius.circular(widget.mediaQ.size.height * 0.01),
              ),
              child: Text(
                widget.sizeList[index],
                style: kProductsSizesTextStyle.copyWith(
                    color: Colors.black,
                    fontFamily: 'AvertaStd-Semibold',
                    fontSize: widget.mediaQ.size.height * 0.028),
              ),
            );
          }

          return GestureDetector(
              onTap: () {
                widget.productStatus != 'Available'
                    ? print('Not Available')
                    : sizeState.setSize(widget.sizeList[index]);

                print('${sizeState.getSizeSelected} size slected');
              },
              child: getContainer);
        }),
      ),
    );
  }
}
