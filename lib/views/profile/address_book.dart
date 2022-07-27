import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/snackbars.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/billing_address.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/views/profile/billing_address_edit.dart';
import 'package:murpanara/views/profile/delivery_address_edit.dart';
import 'package:murpanara/widgets/address_text_widget.dart';
import 'package:murpanara/widgets/edit_or_remove_widget.dart';
import 'package:murpanara/widgets/headings_title.dart';
import 'package:murpanara/widgets/small_info_text.dart';
import 'package:murpanara/widgets/top_heading.dart';
import 'package:provider/provider.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({Key? key}) : super(key: key);

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  final _formKey = GlobalKey<FormState>();

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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,

        centerTitle: true,
        title: Container(
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
            icon: Icon(
              Icons.settings_rounded,
              size: 0.1,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(
              left: _mediaQuery.size.width * 0.04,
              right: _mediaQuery.size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Address Book
              Center(
                child: TopHeading(txt: 'Address Book'),
              ),

              //Billing Address
              Container(
                width: _mediaQuery.size.width,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(
                  top: _mediaQuery.size.height * 0.02,
                ),
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
                        HeadingsTitle(titleText: 'Billing Address'),
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
                            label: 'Edit ',
                            icon: Icon(
                              Icons.edit,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    (billingAddressData.addressLine1.isEmpty ||
                            billingAddressData.addressLine2.isEmpty ||
                            billingAddressData.city.isEmpty ||
                            billingAddressData.pincode == 0)
                        ? Container(
                            child:
                                SmallInfoText(txt: 'No Billing Address found'),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 100,
                                width: 180,
                                // color: Colors.purple,
                                child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    AddressTextWidget(
                                      txt: billingAddressData.addressLine1,
                                      mediaQuery: _mediaQuery,
                                    ),
                                    AddressTextWidget(
                                      txt: billingAddressData.addressLine2,
                                      mediaQuery: _mediaQuery,
                                    ),
                                    AddressTextWidget(
                                      txt:
                                          billingAddressData.pincode.toString(),
                                      mediaQuery: _mediaQuery,
                                    ),
                                    Row(
                                      children: [
                                        AddressTextWidget(
                                            txt: '${billingAddressData.city} ',
                                            mediaQuery: _mediaQuery),
                                        AddressTextWidget(
                                            txt: billingAddressData.state,
                                            mediaQuery: _mediaQuery),
                                      ],
                                    ),
                                    AddressTextWidget(
                                      txt: billingAddressData.country,
                                      mediaQuery: _mediaQuery,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  UserMethods.customDialogBox(
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
                                        print('Billing Address removed');
                                      });
                                },
                                child: EditOrRemoveWidget(
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
                padding: EdgeInsets.all(15),
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
                        HeadingsTitle(titleText: 'Delivery Address'),
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
                            label: 'Edit ',
                            icon: Icon(
                              Icons.edit,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    (deliveryAddressData.addressLine1.isEmpty ||
                            deliveryAddressData.addressLine2.isEmpty ||
                            deliveryAddressData.city.isEmpty ||
                            deliveryAddressData.pincode == 0)
                        ? Container(
                            child:
                                SmallInfoText(txt: 'No Delivery address found'),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // color: Colors.redAccent.withOpacity(0.4),
                                height: 100,
                                width: 180,
                                child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Row(
                                      children: [
                                        AddressTextWidget(
                                          txt:
                                              '${deliveryAddressData.firstName} ',
                                          mediaQuery: _mediaQuery,
                                        ),
                                        AddressTextWidget(
                                          txt: deliveryAddressData.lastName,
                                          mediaQuery: _mediaQuery,
                                        )
                                      ],
                                    ),
                                    AddressTextWidget(
                                      txt: deliveryAddressData.addressLine1,
                                      mediaQuery: _mediaQuery,
                                    ),
                                    AddressTextWidget(
                                      txt: deliveryAddressData.addressLine2,
                                      mediaQuery: _mediaQuery,
                                    ),
                                    AddressTextWidget(
                                      txt: deliveryAddressData.pincode
                                          .toString(),
                                      mediaQuery: _mediaQuery,
                                    ),
                                    Row(
                                      children: [
                                        AddressTextWidget(
                                            txt: '${deliveryAddressData.city} ',
                                            mediaQuery: _mediaQuery),
                                        AddressTextWidget(
                                            txt: deliveryAddressData.state,
                                            mediaQuery: _mediaQuery),
                                      ],
                                    ),
                                    AddressTextWidget(
                                      txt: deliveryAddressData.country,
                                      mediaQuery: _mediaQuery,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone_android_outlined,
                                          size: 10,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        AddressTextWidget(
                                          txt:
                                              '+91 ${deliveryAddressData.phone.toString()}',
                                          mediaQuery: _mediaQuery,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  UserMethods.customDialogBox(
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
                                        print('Delivery Address removed');
                                      });
                                },
                                child: EditOrRemoveWidget(
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
