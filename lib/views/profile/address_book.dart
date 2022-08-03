import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/snackbars.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/billing_address.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/views/profile/billing_address_edit.dart';
import 'package:murpanara/views/profile/delivery_address_edit.dart';
import 'package:murpanara/widgets/address_text_widget.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/edit_or_remove_widget.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/headings_title.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/small_info_text.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/top_heading.dart';
import 'package:provider/provider.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({Key? key}) : super(key: key);

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  @override
  Widget build(BuildContext context) {
    BillingAddress billingAddressData = Provider.of<BillingAddress>(context);
    DeliveryAddress deliveryAddressData = Provider.of<DeliveryAddress>(context);
    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
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
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,

        centerTitle: true,
        title: SizedBox(
          // color: Colors.red,
          height: _mediaQuery.size.height * 0.06,
          width: _mediaQuery.size.width,
          child: Image.asset('assets/images/mpr_main.png'),
        ),

        // backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            splashRadius: 0.1,
            onPressed: () {
              // Navigator.of(context).pushNamed('settingsPage');
            },
            icon: const Icon(
              Icons.settings_rounded,
              size: 0.1,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(
              left: _mediaQuery.size.width * 0.04,
              right: _mediaQuery.size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Address Book
              Center(
                child: TopHeading(
                    margin: EdgeInsets.symmetric(
                        vertical: _mediaQuery.size.height * 0.033),
                    fontSize: _mediaQuery.size.height * 0.028,
                    txt: 'Address Book'),
              ),

              //Billing Address
              Container(
                width: _mediaQuery.size.width,
                padding: EdgeInsets.all(_mediaQuery.size.width * 0.03),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_mediaQuery.size.width * 0.04),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingsTitle(
                            margin: EdgeInsets.only(
                                bottom: _mediaQuery.size.height * 0.03),
                            fontSize: _mediaQuery.size.height * 0.02,
                            titleText: 'Billing Address'),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BillingAddressEdit(),
                              ),
                            );
                          },
                          child: EditOrRemoveWidget(
                            fontSize: _mediaQuery.size.height * 0.014,
                            label: 'Edit ',
                            icon: Icon(
                              Icons.edit,
                              size: _mediaQuery.size.height * 0.018,
                            ),
                          ),
                        ),
                      ],
                    ),
                    (billingAddressData.addressLine1.isEmpty ||
                            billingAddressData.addressLine2.isEmpty ||
                            billingAddressData.city.isEmpty ||
                            billingAddressData.pincode == 0)
                        ? SmallInfoText(
                            margin: EdgeInsets.only(
                                bottom: _mediaQuery.size.height * 0.01,
                                top: _mediaQuery.size.height * 0.02),
                            fontSize: _mediaQuery.size.height * 0.013,
                            txt: 'No Billing Address found',
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: _mediaQuery.size.height * 0.15,
                                width: _mediaQuery.size.width * 0.58,
                                // color: Colors.purple,
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    AddressTextWidget(
                                      txt: billingAddressData.addressLine1,
                                      fontSize: _mediaQuery.size.height * 0.014,
                                    ),
                                    AddressTextWidget(
                                      txt: billingAddressData.addressLine2,
                                      fontSize: _mediaQuery.size.height * 0.014,
                                    ),
                                    AddressTextWidget(
                                      txt:
                                          billingAddressData.pincode.toString(),
                                      fontSize: _mediaQuery.size.height * 0.014,
                                    ),
                                    Row(
                                      children: [
                                        AddressTextWidget(
                                            txt: '${billingAddressData.city} ',
                                            fontSize: _mediaQuery.size.height *
                                                0.014),
                                        AddressTextWidget(
                                            txt: billingAddressData.state,
                                            fontSize: _mediaQuery.size.height *
                                                0.014),
                                      ],
                                    ),
                                    AddressTextWidget(
                                      txt: billingAddressData.country,
                                      fontSize: _mediaQuery.size.height * 0.014,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  UserMethods.customDialogBox(
                                      borderRadius:
                                          _mediaQuery.size.width * 0.06,
                                      contentPadding:
                                          _mediaQuery.size.width * 0.04,
                                      contentContainerHeight:
                                          _mediaQuery.size.height * 0.28,
                                      headingTextTopMargin:
                                          _mediaQuery.size.height * 0.02,
                                      headingTextFontSize:
                                          _mediaQuery.size.height * 0.025,
                                      mprEyeContainerHeight:
                                          _mediaQuery.size.width * 0.07,
                                      mprEyeContainerWidth:
                                          _mediaQuery.size.width * 0.07,
                                      bigSizedBoxHeight:
                                          _mediaQuery.size.height * 0.03,
                                      smallSizedBoxHeight:
                                          _mediaQuery.size.height * 0.03,
                                      textButtonHorizontalPadding:
                                          _mediaQuery.size.width * 0.05,
                                      textButtonVerticalpadding:
                                          _mediaQuery.size.height * 0.008,
                                      textButtonBorderRadius:
                                          _mediaQuery.size.width * 0.06,
                                      cancelText: 'No',
                                      confirmText: 'Yes',
                                      context: context,
                                      mediaQuery: _mediaQuery,
                                      headingText: 'Remove Billing Address',
                                      subText:
                                          'Do you want to remove Billing Address?',
                                      confirmFunction: () async {
                                        Navigator.of(context).pop();

                                        await DatabaseServices()
                                            .removeBillingAddress();

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                billingAddressRemovedSnackbar);
                                        // print('Billing Address removed');
                                      });
                                },
                                child: EditOrRemoveWidget(
                                  fontSize: _mediaQuery.size.height * 0.014,
                                  label: 'Remove Address',
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),

              //Delivery Address
              Container(
                width: _mediaQuery.size.width,
                padding: EdgeInsets.all(_mediaQuery.size.width * 0.03),
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.01),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_mediaQuery.size.width * 0.04),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingsTitle(
                            margin: EdgeInsets.only(
                                bottom: _mediaQuery.size.height * 0.03),
                            fontSize: _mediaQuery.size.height * 0.02,
                            titleText: 'Delivery Address'),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DeliveryAddressEdit(),
                              ),
                            );
                          },
                          child: EditOrRemoveWidget(
                            fontSize: _mediaQuery.size.height * 0.014,
                            label: 'Edit ',
                            icon: Icon(
                              Icons.edit,
                              size: _mediaQuery.size.height * 0.018,
                            ),
                          ),
                        ),
                      ],
                    ),
                    (deliveryAddressData.addressLine1.isEmpty ||
                            deliveryAddressData.addressLine2.isEmpty ||
                            deliveryAddressData.city.isEmpty ||
                            deliveryAddressData.pincode == 0)
                        ? SmallInfoText(
                            margin: EdgeInsets.only(
                                bottom: _mediaQuery.size.height * 0.01,
                                top: _mediaQuery.size.height * 0.02),
                            fontSize: _mediaQuery.size.height * 0.013,
                            txt: 'No Delivery Address found',
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // color: Colors.redAccent.withOpacity(0.4),
                                height: _mediaQuery.size.height * 0.15,
                                width: _mediaQuery.size.width * 0.58,
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Row(
                                      children: [
                                        AddressTextWidget(
                                          txt:
                                              '${deliveryAddressData.firstName} ',
                                          fontSize:
                                              _mediaQuery.size.height * 0.014,
                                        ),
                                        AddressTextWidget(
                                          txt: deliveryAddressData.lastName,
                                          fontSize:
                                              _mediaQuery.size.height * 0.014,
                                        )
                                      ],
                                    ),
                                    AddressTextWidget(
                                      txt: deliveryAddressData.addressLine1,
                                      fontSize: _mediaQuery.size.height * 0.014,
                                    ),
                                    AddressTextWidget(
                                      txt: deliveryAddressData.addressLine2,
                                      fontSize: _mediaQuery.size.height * 0.014,
                                    ),
                                    AddressTextWidget(
                                      txt: deliveryAddressData.pincode
                                          .toString(),
                                      fontSize: _mediaQuery.size.height * 0.014,
                                    ),
                                    Row(
                                      children: [
                                        AddressTextWidget(
                                            txt: '${deliveryAddressData.city} ',
                                            fontSize: _mediaQuery.size.height *
                                                0.014),
                                        AddressTextWidget(
                                            txt: deliveryAddressData.state,
                                            fontSize: _mediaQuery.size.height *
                                                0.014),
                                      ],
                                    ),
                                    AddressTextWidget(
                                      txt: deliveryAddressData.country,
                                      fontSize: _mediaQuery.size.height * 0.014,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone_android_outlined,
                                          size: _mediaQuery.size.height * 0.014,
                                        ),
                                        SizedBox(
                                          width: _mediaQuery.size.width * 0.006,
                                        ),
                                        AddressTextWidget(
                                          txt:
                                              '+91 ${deliveryAddressData.phone.toString()}',
                                          fontSize:
                                              _mediaQuery.size.height * 0.014,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  UserMethods.customDialogBox(
                                      borderRadius:
                                          _mediaQuery.size.width * 0.06,
                                      contentPadding:
                                          _mediaQuery.size.width * 0.04,
                                      contentContainerHeight:
                                          _mediaQuery.size.height * 0.28,
                                      headingTextTopMargin:
                                          _mediaQuery.size.height * 0.02,
                                      headingTextFontSize:
                                          _mediaQuery.size.height * 0.025,
                                      mprEyeContainerHeight:
                                          _mediaQuery.size.width * 0.07,
                                      mprEyeContainerWidth:
                                          _mediaQuery.size.width * 0.07,
                                      bigSizedBoxHeight:
                                          _mediaQuery.size.height * 0.03,
                                      smallSizedBoxHeight:
                                          _mediaQuery.size.height * 0.03,
                                      textButtonHorizontalPadding:
                                          _mediaQuery.size.width * 0.05,
                                      textButtonVerticalpadding:
                                          _mediaQuery.size.height * 0.008,
                                      textButtonBorderRadius:
                                          _mediaQuery.size.width * 0.06,
                                      cancelText: 'No',
                                      confirmText: 'Yes',
                                      context: context,
                                      mediaQuery: _mediaQuery,
                                      headingText: 'Remove Delivery Address',
                                      subText:
                                          'Do you want to remove Delivery Address?',
                                      confirmFunction: () async {
                                        Navigator.of(context).pop();
                                        await DatabaseServices()
                                            .removeDeliveryAddress();

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                deliveryAddressRemovedSnackbar);
                                        // print('Delivery Address removed');
                                      });
                                },
                                child: EditOrRemoveWidget(
                                  fontSize: _mediaQuery.size.height * 0.014,
                                  label: 'Remove Address',
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
