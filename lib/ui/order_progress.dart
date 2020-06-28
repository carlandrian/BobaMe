import 'package:boba_me/model/boba_cart_model.dart';
import 'package:boba_me/model/boba_order_model.dart';
import 'package:boba_me/ui/product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_widgets/custom_widgets.dart';
// TODO: properly style this screen.
class OrderProgressScreen extends StatefulWidget {
  @override
  _OrderProgressScreenState createState() => _OrderProgressScreenState();
}

class _OrderProgressScreenState extends State<OrderProgressScreen> {
  @override
  Widget build(BuildContext context) {
    BobaCartModel bobaCart = Provider.of<BobaCartModel>(context);
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BobaBannerImage(),
              Text("We are now processing your Boba. Thank you for ordering!"),
              processOrderWidget(context, bobaCart),
            ],
          ),
        ),
      ),
    );
  }

  Widget processOrderWidget (BuildContext context, BobaCartModel bobaCart) {
    var orderProgressCount = 0;
    debugPrint("${bobaCart.bobaOrdersMap.length}");
    try {
      bobaCart.bobaOrdersMap.forEach((key, value) async {
        BobaOrderModel order = value;
        await Firestore.instance.collection('BobaOrders').add(
            {
              'customer_info_id': bobaCart.bobaCustomerInfo.uid,
              'boba_product_name': order.bobaProductName,
              'milk_type_name': order.milkTypeName,
              'order_count': order.orderCount,
              'order_status': 'ORDER_REQUESTED',
            }
        );
      });
    }catch(e){
      print(e);
    }

    return RaisedButton(
      child: Text(
          "Continue Shopping for Boba!",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: (){
        bobaCart.clearOrders();
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ProductScreen(),
        ));
      },
    );
  }
}

