import 'package:boba_me/model/boba_customer.dart';
import 'package:boba_me/model/boba_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

BobaCustomer _bobaCustomer;
BobaCartModel _bobaCart;

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _auth = FirebaseAuth.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bobaCart = Provider.of<BobaCartModel>(context);
    _bobaCustomer = _bobaCart.bobaCustomerInfo;
    print("Customer Name : ${_bobaCustomer.customerName.toString()}");
    //print("Deliver To : ${_bobaCustomer.deliverTo.toString()}");
    //print("Town/City : ${_bobaCustomer.townCity.toString()}");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.pinkAccent),
        title: Text(
          "PAYMENT",
            style: TextStyle(
              color: Colors.white,
              //fontSize: 19,
              fontWeight: FontWeight.bold,
              letterSpacing: 3
            ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "DELIVER TO:",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _bobaCustomer.deliverTo.toString(),
              style: TextStyle(
                color: Colors.white30,
              ),
            ),
            Text(
              _bobaCustomer.addressLine1 + " " +_bobaCustomer.addressLine2,
              style: TextStyle(
                color: Colors.white30,
              ),
            ),
            Text(
              _bobaCustomer.townCity + " " + _bobaCustomer.province,
              style: TextStyle(
                color: Colors.white30,
              ),
            ),
            Text(
              _bobaCustomer.phoneNumber,
              style: TextStyle(
                color: Colors.white30,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  " Cancel ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19
                  ),
                ),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 40,
              ),
              RaisedButton(
                child: Text(
                  "   Next  ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19
                  ),
                ),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed:
                  //nextButtonEnabled || (_bobaOrdersMap.length < 3)? () {
                  //Navigator.push(context, MaterialPageRoute(
                  //  builder: (context) => AddressScreen(),
                  //));
                //} : null
                () {

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
