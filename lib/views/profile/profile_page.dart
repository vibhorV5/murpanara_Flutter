import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/billing_address.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/personal_details.dart';
import 'package:murpanara/views/profile/address_book.dart';
import 'package:murpanara/views/profile/personal_details_edit.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/headings_title.dart';
import 'package:murpanara/widgets/address_text_widget.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/edit_or_remove_widget.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/personal_info_field.dart';
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
          margin: EdgeInsets.symmetric(
            vertical: _mediaQuery.size.height * 0.04,
            horizontal: _mediaQuery.size.width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Hi, Member
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
                padding: EdgeInsets.all(_mediaQuery.size.width * 0.04),
                // height: _mediaQuery.size.height * 0.56,
                width: _mediaQuery.size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingsTitle(
                          fontSize: _mediaQuery.size.height * 0.024,
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.03),
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
                            fontSize: _mediaQuery.size.height * 0.016,
                            label: 'Edit ',
                            icon: Icon(
                              Icons.edit,
                              size: _mediaQuery.size.height * 0.02,
                            ),
                          ),
                        ),
                      ],
                    ),
                    PersonalInfoField(
                      headingTextSize: _mediaQuery.size.height * 0.016,
                      userInfoTextSize: _mediaQuery.size.height * 0.015,
                      sizedBoxHeight: _mediaQuery.size.height * 0.0001,
                      headingText: 'First name',
                      userInfoText: personalDetailsData.firstName,
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.01,
                    ),
                    PersonalInfoField(
                      headingTextSize: _mediaQuery.size.height * 0.016,
                      userInfoTextSize: _mediaQuery.size.height * 0.015,
                      sizedBoxHeight: _mediaQuery.size.height * 0.0001,
                      headingText: 'Last name',
                      userInfoText: personalDetailsData.lastName,
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.01,
                    ),
                    PersonalInfoField(
                      headingTextSize: _mediaQuery.size.height * 0.016,
                      userInfoTextSize: _mediaQuery.size.height * 0.015,
                      sizedBoxHeight: _mediaQuery.size.height * 0.0001,
                      headingText: 'Date of birth',
                      userInfoText: personalDetailsData.dob,
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.01,
                    ),
                    PersonalInfoField(
                      headingTextSize: _mediaQuery.size.height * 0.016,
                      userInfoTextSize: _mediaQuery.size.height * 0.015,
                      sizedBoxHeight: _mediaQuery.size.height * 0.0001,
                      headingText: 'Phone number',
                      userInfoText: UserMethods.checkNumField(
                          personalDetailsData.phoneNumber!),
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.01,
                    ),
                    PersonalInfoField(
                      headingTextSize: _mediaQuery.size.height * 0.016,
                      userInfoTextSize: _mediaQuery.size.height * 0.015,
                      sizedBoxHeight: _mediaQuery.size.height * 0.0001,
                      headingText: 'Gender',
                      userInfoText: personalDetailsData.gender,
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.01,
                    ),
                    PersonalInfoField(
                      headingTextSize: _mediaQuery.size.height * 0.016,
                      userInfoTextSize: _mediaQuery.size.height * 0.015,
                      sizedBoxHeight: _mediaQuery.size.height * 0.0001,
                      headingText: 'Postal Code',
                      userInfoText: UserMethods.checkNumField(
                          deliveryAddressData.pincode!),
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.01,
                    ),
                    PersonalInfoField(
                      headingTextSize: _mediaQuery.size.height * 0.016,
                      userInfoTextSize: _mediaQuery.size.height * 0.015,
                      sizedBoxHeight: _mediaQuery.size.height * 0.0001,
                      headingText: 'Country',
                      userInfoText: 'India',
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.01,
                    ),
                  ],
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
                  padding: EdgeInsets.all(_mediaQuery.size.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadingsTitle(
                            fontSize: _mediaQuery.size.height * 0.024,
                            margin: EdgeInsets.only(
                                bottom: _mediaQuery.size.height * 0.03),
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
                              fontSize: _mediaQuery.size.height * 0.016,
                              label: 'Edit ',
                              icon: Icon(
                                Icons.edit,
                                size: _mediaQuery.size.height * 0.02,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: _mediaQuery.size.height * 0.01),
                            child: Text(
                              'Billing address',
                              style: kSemibold
                                  .copyWith(
                                      fontSize: _mediaQuery.size.height * 0.016)
                                  .copyWith(
                                    color: Colors.black45,
                                  ),
                            ),
                          ),
                          (billingAddressData.addressLine1.isEmpty ||
                                  billingAddressData.addressLine2.isEmpty ||
                                  billingAddressData.city.isEmpty ||
                                  billingAddressData.pincode == 0)
                              ? Container()
                              : SizedBox(
                                  height: _mediaQuery.size.height * 0.11,
                                  // color: Colors.purple,
                                  child: ListView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      AddressTextWidget(
                                        txt: billingAddressData.addressLine1,
                                        fontSize:
                                            _mediaQuery.size.height * 0.014,
                                      ),
                                      AddressTextWidget(
                                        txt: billingAddressData.addressLine2,
                                        fontSize:
                                            _mediaQuery.size.height * 0.014,
                                      ),
                                      AddressTextWidget(
                                        txt: billingAddressData.pincode
                                            .toString(),
                                        fontSize:
                                            _mediaQuery.size.height * 0.014,
                                      ),
                                      Row(
                                        children: [
                                          AddressTextWidget(
                                              txt:
                                                  '${billingAddressData.city}, ',
                                              fontSize:
                                                  _mediaQuery.size.height *
                                                      0.014),
                                          AddressTextWidget(
                                              txt: billingAddressData.state,
                                              fontSize:
                                                  _mediaQuery.size.height *
                                                      0.014),
                                        ],
                                      ),
                                      AddressTextWidget(
                                        txt: billingAddressData.country,
                                        fontSize:
                                            _mediaQuery.size.height * 0.014,
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: _mediaQuery.size.height * 0.01),
                        child: Text(
                          'Delivery address',
                          style: kSemibold
                              .copyWith(
                                  fontSize: _mediaQuery.size.height * 0.016)
                              .copyWith(
                                color: Colors.black45,
                              ),
                        ),
                      ),
                      (deliveryAddressData.addressLine1.isEmpty ||
                              deliveryAddressData.addressLine2.isEmpty ||
                              deliveryAddressData.city.isEmpty ||
                              deliveryAddressData.pincode == 0)
                          ? Container()
                          : SizedBox(
                              height: _mediaQuery.size.height * 0.13,
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
                                    txt: deliveryAddressData.pincode.toString(),
                                    fontSize: _mediaQuery.size.height * 0.014,
                                  ),
                                  Row(
                                    children: [
                                      AddressTextWidget(
                                          txt: '${deliveryAddressData.city}, ',
                                          fontSize:
                                              _mediaQuery.size.height * 0.014),
                                      AddressTextWidget(
                                          txt: deliveryAddressData.state,
                                          fontSize:
                                              _mediaQuery.size.height * 0.014),
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
                                        size: _mediaQuery.size.height * 0.015,
                                      ),
                                      SizedBox(
                                        width: _mediaQuery.size.width * 0.01,
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
