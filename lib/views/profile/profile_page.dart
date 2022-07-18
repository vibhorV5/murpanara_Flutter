import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/billing_address.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/personal_details.dart';
import 'package:murpanara/views/profile/address_book.dart';
import 'package:murpanara/views/profile/personal_details_edit.dart';
import 'package:murpanara/widgets/address_text_widget.dart';
import 'package:murpanara/widgets/edit_or_remove_widget.dart';
import 'package:murpanara/widgets/personal_info_field.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    PersonalDetails personalDetailsData = Provider.of<PersonalDetails>(context);
    BillingAddress billingAddressData = Provider.of<BillingAddress>(context);
    DeliveryAddress deliveryAddressData = Provider.of<DeliveryAddress>(context);

    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      // backgroundColor: Colors.white,
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
              top: _mediaQuery.size.height * 0.04,
              left: _mediaQuery.size.width * 0.04,
              right: _mediaQuery.size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi, ${UserMethods.checkUserName(personalDetailsData.firstName)}',
                  style:
                      kBold.copyWith(fontSize: _mediaQuery.size.height * 0.05),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.04),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_mediaQuery.size.width * 0.04),
                  color: Colors.grey.shade200,
                ),
                // height: _mediaQuery.size.height * 0.56,
                width: _mediaQuery.size.width,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadingsTitle(
                            titleText: 'Personal details',
                          ),

                          //Edit Personal details
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PersonalDetailsEdit(),
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
                      PersonalInfoField(
                        titleField: 'First name',
                        userTitleField: personalDetailsData.firstName,
                      ),
                      PersonalInfoField(
                        titleField: 'Last name',
                        userTitleField: personalDetailsData.lastName,
                      ),
                      PersonalInfoField(
                        titleField: 'Date of birth',
                        userTitleField: personalDetailsData.dob,
                      ),
                      PersonalInfoField(
                        titleField: 'Phone number',
                        userTitleField: UserMethods.checkNumField(
                            personalDetailsData.phoneNumber!),
                      ),
                      PersonalInfoField(
                        titleField: 'Gender',
                        userTitleField: personalDetailsData.gender,
                      ),
                      PersonalInfoField(
                        titleField: 'Postal Code',
                        userTitleField: UserMethods.checkNumField(
                            deliveryAddressData.pincode!),
                      ),
                      PersonalInfoField(
                        titleField: 'Country',
                        userTitleField: 'India',
                      ),
                    ],
                  ),
                ),
              ),

              //My Addresses
              Container(
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.01),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_mediaQuery.size.width * 0.04),
                  color: Colors.grey.shade200,
                ),
                // height: _mediaQuery.size.height * 0.4,
                width: _mediaQuery.size.width,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadingsTitle(
                            titleText: 'My Addresses',
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const AddressBook(),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Billing address',
                              style: kSemibold.copyWith(
                                  fontSize: 13, color: Colors.black45),
                            ),
                          ),
                          (billingAddressData.addressLine1.isEmpty ||
                                  billingAddressData.addressLine2.isEmpty ||
                                  billingAddressData.city.isEmpty ||
                                  billingAddressData.pincode == 0)
                              ? Container()
                              : Container(
                                  height: 100,
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
                                        txt: billingAddressData.pincode
                                            .toString(),
                                        mediaQuery: _mediaQuery,
                                      ),
                                      Row(
                                        children: [
                                          AddressTextWidget(
                                              txt:
                                                  '${billingAddressData.city}, ',
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
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Delivery address',
                          style: kSemibold.copyWith(
                              fontSize: 13, color: Colors.black45),
                        ),
                      ),
                      (deliveryAddressData.addressLine1.isEmpty ||
                              deliveryAddressData.addressLine2.isEmpty ||
                              deliveryAddressData.city.isEmpty ||
                              deliveryAddressData.pincode == 0)
                          ? Container()
                          : Container(
                              height: 100,
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
                                    txt: deliveryAddressData.pincode.toString(),
                                    mediaQuery: _mediaQuery,
                                  ),
                                  Row(
                                    children: [
                                      AddressTextWidget(
                                          txt: '${deliveryAddressData.city}, ',
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
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeadingsTitle extends StatelessWidget {
  const HeadingsTitle({Key? key, required this.titleText}) : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Text(
        titleText,
        style: kSemibold.copyWith(fontSize: 18),
      ),
    );
  }
}
