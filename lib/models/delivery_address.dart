class DeliveryAddress {
  final String firstName;
  final String lastName;
  final String addressLine1;
  final String addressLine2;
  final num? pincode;
  final String city;
  final String state;
  final String country;
  final num? phone;

  DeliveryAddress({
    this.firstName = '',
    this.lastName = '',
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.pincode = 0,
    this.city = '',
    this.state = '',
    this.country = '',
    this.phone = 0,
  });
}
