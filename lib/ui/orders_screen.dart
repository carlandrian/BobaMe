import 'package:boba_me/model/boba_cart_model.dart';
import 'package:boba_me/ui/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_widgets/custom_widgets.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _auth = FirebaseAuth.instance;

  var bobaOrdersDb =
  Firestore.instance.collection('BobaOrders')
      .where("customer_info_id", isEqualTo: "i36YHr8WeqZW3llfqG7fsQ2NlS92")
      .where("order_status", isEqualTo: "ORDER_REQUESTED")
      .orderBy("order_status_date", descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    BobaCartModel bobaCartModel = Provider.of<BobaCartModel>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          ButtonSwitchBanner(
            button1Text: "PROFILE",
            button2Text: "ORDERS",
            button1Highlighted: false,
            button2Highlighted: true,
            button1DestScreenWidget: ProfileScreen(),
            button2DestScreenWidget: null,
          ),
          Text(
            "MOST RECENT",
            style: TextStyle(
              color: Colors.white30,
              letterSpacing: 2,
            ),
          ),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: bobaOrdersDb,
                builder: (context, snapshots) {
                  if (!snapshots.hasData) return CircularProgressIndicator();
//                  debugPrint("snapshots.data.documents.length : ${snapshots.data.documents.length}");
                  return ListView.builder(
                    itemCount: snapshots.data.documents.length,
                    itemBuilder: (context, int index) {
//                      debugPrint("index $index");
                      return Container(
                        child: Column(
                          children: <Widget>[
                            FutureBuilder(
                              future: getRequestedCustomerOrders(context, snapshots.data.documents[index]),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done) {
                                  return Container(
                                    child: snapshot.data,
                                  );
                                }

                                if(snapshot.connectionState == ConnectionState.waiting) {
                                  return Container(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        )
                      );
                    }
                  );
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: BobaNavigationBar(
        bobaCartModel: bobaCartModel,
      ),
    );
  }

  Future<Widget> getRequestedCustomerOrders(BuildContext context, DocumentSnapshot document) async {
    return await Column(
      children: <Widget>[
        Text(
          "Boba: ${document['boba_product_name']}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "Milk: ${document['milk_type']}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "Sweetnes: ${document['sweetness_level']}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "Ice: ${document['ice_level']}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "Toppings: ${document['toppings']}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "Order Status: ${document['order_status']}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "Order Date: ${document['order_status_date']}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          "Deliver to: ${document['deliver_to']}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        SizedBox(
          width: 250,
          child: Divider(
            color: Colors.white30,
          ),
        ),
      ],
    );
  }
}




