import 'package:flutter/material.dart';

import 'boba_cart_model.dart';

class BobaCustomer {
  var customerName;
  var deliverTo;
  var addressLine1;
  var addressLine2;
  var townCity;
  var province;
  var phoneNumber;
  var uid;
  var email;
  var firstName;
  var lastName;

  BobaCustomer({this.customerName, this.deliverTo, this.addressLine1,
    this.addressLine2, this.townCity, this.province, this.phoneNumber,
    this.uid, this.firstName, this.lastName
  });
}