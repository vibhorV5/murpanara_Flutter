import 'package:flutter/material.dart';
import 'package:murpanara/constants/about_us_texts.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/widgets/AboutUsRefundPageWidgets/big_image_widget.dart';
import 'package:murpanara/widgets/AboutUsRefundPageWidgets/bold_text.dart';
import 'package:murpanara/widgets/AboutUsRefundPageWidgets/regular_text.dart';
import 'package:murpanara/widgets/AboutUsRefundPageWidgets/semibold_text.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: _mediaQuery.size.width * 0.065,
            color: kColorBackIconForgotPassPage,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: _mediaQuery.size.width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigImageWidget(
                height: _mediaQuery.size.height * 0.28,
                width: _mediaQuery.size.width,
                imageUrl: 'assets/images/mpr_main.png',
              ),
              SizedBox(
                height: _mediaQuery.size.height * 0.05,
              ),
              BoldText(
                fontSize: _mediaQuery.size.height * 0.04,
                txt: 'About Us',
              ),
              SizedBox(
                height: _mediaQuery.size.height * 0.004,
              ),
              RegularText(
                fontSize: _mediaQuery.size.height * 0.017,
                txt: aboutUsText,
              ),
              RegularText(
                fontSize: _mediaQuery.size.height * 0.017,
                txt: aboutUsText2,
              ),
              SizedBox(
                height: _mediaQuery.size.height * 0.05,
              ),
              BoldText(
                fontSize: _mediaQuery.size.height * 0.04,
                txt: 'Contact Us',
              ),
              SizedBox(
                height: _mediaQuery.size.height * 0.004,
              ),
              SemiBoldText(
                fontSize: _mediaQuery.size.height * 0.017,
                txt: supportText,
              ),
              SizedBox(
                height: _mediaQuery.size.height * 0.13,
              ),
              Center(
                child: SemiBoldText(
                  fontSize: _mediaQuery.size.height * 0.017,
                  txt: copyRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
