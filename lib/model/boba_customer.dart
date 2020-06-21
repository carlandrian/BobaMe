import 'package:flutter/material.dart';

import 'boba_cart_model.dart';

class BobaCustomer {
  var customerName;
  var addressLine1;
  var addressLine2;
  var townCity;
  var province;
  var phoneNumber;
  BobaCartModel bobaCart;

  BobaCustomer({this.customerName, this.addressLine1, this.addressLine2,
    this.townCity, this.province, this.phoneNumber, this.bobaCart});
}