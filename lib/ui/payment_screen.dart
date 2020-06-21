import 'package:boba_me/model/boba_customer.dart';
import 'package:flutter/material.dart';

BobaCustomer _bobaCustomer;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key key, this.bobaCustomer}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();

  final BobaCustomer bobaCustomer;
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
