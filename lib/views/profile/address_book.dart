import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/billing_address.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/views/profile/billing_address_edit.dart';
import 'package:murpanara/views/profile/delivery_address_edit.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({Key? key}) : super(key: key);

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                          child: EditWidget(),
                        ),
                      ],
                    ),
                    // SmallInfoText(txt: 'No Billing Address found'),
                    StreamBuilder(
                      stream: DatabaseServices().billingAddressStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                              // color: Colors.yellow,
                              height: 100,
                              child: SmallInfoText(
                                  txt: 'No Billing Address found'));
                        } else if (snapshot.hasData) {
                          var data = snapshot.data!;
                          BillingAddress billingAddress =
                              data as BillingAddress;
                          print(billingAddress);
                          return (data.addressLine1.isEmpty)
                              ? Container(
                                  height: 100,
                                  child: SmallInfoText(
                                      txt: 'No Billing Address found'))
                              : Container(
                                  height: 100,
                                  child: ListView(
                                    children: [
                                      AddressTextWidget(
                                        txt: data.addressLine1,
                                        mediaQuery: _mediaQuery,
                                      ),
                                      AddressTextWidget(
                                        txt: data.addressLine2,
                                        mediaQuery: _mediaQuery,
                                      ),
                                      AddressTextWidget(
                                        txt: data.pincode.toString(),
                                        mediaQuery: _mediaQuery,
                                      ),
                                      Row(
                                        children: [
                                          AddressTextWidget(
                                              txt: '${data.city}, ',
                                              mediaQuery: _mediaQuery),
                                          AddressTextWidget(
                                              txt: data.state,
                                              mediaQuery: _mediaQuery),
                                        ],
                                      ),
                                      AddressTextWidget(
                                        txt: data.country,
                                        mediaQuery: _mediaQuery,
                                      ),
                                    ],
                                  ));
                        } else {
                          print('error');
                          return SmallInfoText(txt: 'No Billing Address found');
                        }
                      },
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
                          child: EditWidget(),
                        ),
                      ],
                    ),
                    // SmallInfoText(txt: 'No Delivery address found'),

                    StreamBuilder(
                      stream: DatabaseServices().deliveryAddressStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            // color: Colors.yellow,
                            height: 100,
                            child:
                                SmallInfoText(txt: 'No Delivery Address found'),
                          );
                        } else if (snapshot.hasData) {
                          var data = snapshot.data!;
                          DeliveryAddress deliveryAddress =
                              data as DeliveryAddress;
                          print(deliveryAddress);
                          return (data.addressLine1.isEmpty)
                              ? Container(
                                  height: 100,
                                  child: SmallInfoText(
                                      txt: 'No Delivery Address found'))
                              : Container(
                                  height: 100,
                                  child: ListView(
                                    children: [
                                      Row(
                                        children: [
                                          AddressTextWidget(
                                            txt: '${data.firstName} ',
                                            mediaQuery: _mediaQuery,
                                          ),
                                          AddressTextWidget(
                                            txt: data.lastName,
                                            mediaQuery: _mediaQuery,
                                          )
                                        ],
                                      ),
                                      AddressTextWidget(
                                        txt: data.addressLine1,
                                        mediaQuery: _mediaQuery,
                                      ),
                                      AddressTextWidget(
                                        txt: data.addressLine2,
                                        mediaQuery: _mediaQuery,
                                      ),
                                      AddressTextWidget(
                                        txt: data.pincode.toString(),
                                        mediaQuery: _mediaQuery,
                                      ),
                                      Row(
                                        children: [
                                          AddressTextWidget(
                                              txt: '${data.city}, ',
                                              mediaQuery: _mediaQuery),
                                          AddressTextWidget(
                                              txt: data.state,
                                              mediaQuery: _mediaQuery),
                                        ],
                                      ),
                                      AddressTextWidget(
                                        txt: data.country,
                                        mediaQuery: _mediaQuery,
                                      ),
                                    ],
                                  ),
                                );
                        } else {
                          print('hello error');
                          return SmallInfoText(
                              txt: 'No Delivery Address found');
                        }
                      },
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

class AddressTextWidget extends StatelessWidget {
  const AddressTextWidget({
    Key? key,
    required this.txt,
    required MediaQueryData mediaQuery,
  })  : _mediaQuery = mediaQuery,
        super(key: key);

  final String txt;
  final MediaQueryData _mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: kSemibold.copyWith(
        fontSize: _mediaQuery.size.height * 0.014,
      ),
    );
  }
}

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
            margin: EdgeInsets.only(bottom: 15),
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

class TopHeading extends StatelessWidget {
  const TopHeading({
    Key? key,
    required this.txt,
  }) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, top: 30),
      child: Text(
        txt,
        style: kSemibold.copyWith(fontSize: 22),
      ),
    );
  }
}

class HeadingsTitle extends StatelessWidget {
  const HeadingsTitle({
    Key? key,
    required this.titleText,
  }) : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Text(
        titleText,
        style: kSemibold.copyWith(fontSize: 15),
      ),
    );
  }
}

class SmallInfoText extends StatelessWidget {
  const SmallInfoText({
    Key? key,
    required this.txt,
  }) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2, top: 5),
      child: Text(
        txt,
        style: kSemibold.copyWith(fontSize: 10).copyWith(
              color: Colors.black45,
            ),
      ),
    );
  }
}
