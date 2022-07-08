import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/views/profile/address_book.dart';
import 'package:murpanara/views/profile/billing_address_edit.dart';
import 'package:murpanara/views/profile/personal_details_edit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final _mediaQuery = MediaQuery.of(context);

    TextEditingController nameController = TextEditingController();

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
                  'Hi Member',
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
                            child: EditWidget(),
                          ),
                        ],
                      ),
                      PersonalInfoField(
                        titleField: 'First name',
                        userTitleField: 'Member',
                      ),
                      PersonalInfoField(
                        titleField: 'Last name',
                        userTitleField: '-',
                      ),
                      PersonalInfoField(
                        titleField: 'Date of birth',
                        userTitleField: '-',
                      ),
                      PersonalInfoField(
                        titleField: 'Phone number',
                        userTitleField: '-',
                      ),
                      PersonalInfoField(
                        titleField: 'Gender',
                        userTitleField: '-',
                      ),
                      PersonalInfoField(
                        titleField: 'Postal Code',
                        userTitleField: '-',
                      ),
                      PersonalInfoField(
                        titleField: 'Country',
                        userTitleField: '-',
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
                            child: Container(
                              // color: Colors.pink,
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
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Billing address',
                          style: kSemibold.copyWith(
                              fontSize: 13, color: Colors.black45),
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

class PersonalInfoField extends StatelessWidget {
  const PersonalInfoField(
      {Key? key, required this.titleField, required this.userTitleField})
      : super(key: key);

  final String titleField;
  final String userTitleField;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 2),
          child: Text(
            titleField,
            style: kSemibold.copyWith(fontSize: 13).copyWith(
                  color: Colors.black45,
                ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Text(
            userTitleField,
            style: kSemibold.copyWith(fontSize: 13, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
