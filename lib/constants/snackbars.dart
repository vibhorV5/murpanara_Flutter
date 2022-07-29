import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';

SnackBar itemAddedToWishlistSnackBar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Product added to Wishlist.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar itemRemovedFromWishlistSnackBar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Product removed from Wishlist.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar errorSnackBar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Please select a Size.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar successSnackBar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Product added to your Shopping Cart.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar itemAlreadyPresentSnackBar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Product already present in your Shopping Cart.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar itemRemovedFromShoppingCartSnackBar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Product removed from Shopping Cart.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar invalidEmailSnackBar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Enter a Valid Email ID.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar emailNotRegisteredSnackBar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Enter Registered Email ID.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar billingAddressRemovedSnackbar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Billing Address removed.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar deliveryAddressRemovedSnackbar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Delivery Address removed.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar billingAddressSavedSnackbar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Billing Address saved.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar deliveryAddressSavedSnackbar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Delivery Address saved.',
    style: kSnackBarTextStyleAuthPage,
  ),
);

SnackBar personalDetailsSavedSnackbar = const SnackBar(
  duration: Duration(seconds: 2),
  elevation: 10,
  backgroundColor: kColorSnackBarBackgroundAuthPage,
  content: Text(
    'Personal Details saved.',
    style: kSnackBarTextStyleAuthPage,
  ),
);
