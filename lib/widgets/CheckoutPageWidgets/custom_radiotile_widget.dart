import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/providers/checkout_details_provider.dart';
import 'package:murpanara/views/checkout/checkout_page.dart';
import 'package:provider/provider.dart';

class CustomRadioTileWidget extends StatefulWidget {
  const CustomRadioTileWidget({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  final double fontSize;

  @override
  State<CustomRadioTileWidget> createState() => _CustomRadioTileWidgetState();
}

class _CustomRadioTileWidgetState extends State<CustomRadioTileWidget> {
  @override
  Widget build(BuildContext context) {
    CheckoutDetailsProvider checkoutDetailsProviderData =
        Provider.of<CheckoutDetailsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile<ModeOfPayment>(
          value: ModeOfPayment.razorPay,
          groupValue: checkoutDetailsProviderData.currentSelectedModeOfPayment,
          onChanged: (ModeOfPayment? value) {
            setState(() {
              checkoutDetailsProviderData.modeOfPaymentValue(value!);
              // paymentModeSelect = value;
              debugPrint(checkoutDetailsProviderData
                  .currentSelectedModeOfPayment
                  .toString());
            });
          },
          title: Text(
            'RazorPay',
            style: kSemibold.copyWith(
              fontSize: widget.fontSize,
            ),
          ),
        ),
        RadioListTile<ModeOfPayment>(
          value: ModeOfPayment.cashOnDelivery,
          groupValue: checkoutDetailsProviderData.currentSelectedModeOfPayment,
          onChanged: (ModeOfPayment? value) {
            setState(() {
              // paymentModeSelect = value;
              checkoutDetailsProviderData.modeOfPaymentValue(value!);
              debugPrint(checkoutDetailsProviderData
                  .currentSelectedModeOfPayment
                  .toString());
            });
          },
          title: Text(
            'Cash on Delivery',
            style: kSemibold.copyWith(
              fontSize: widget.fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
