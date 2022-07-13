class BillingAddress {
  final String addressLine1;
  final String addressLine2;
  final num pincode;
  final String city;
  final String state;
  final String country;

  BillingAddress({
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.pincode = 0,
    this.city = '',
    this.state = '',
    this.country = '',
  });
}
