import 'package:boba_me/model/boba_cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  @override
  Widget build(BuildContext context) {
    var bobaCart = Provider.of<BobaCartModel>(context);
    print("bobaCart orderCountMap: ${bobaCart.orderCountMap}");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "CHECKOUT",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 3
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: bobaCart.bobaOrders.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Column(
                children: <Widget>[
                  BobaOrder(bobaCart: bobaCart, index: index,),
                  // add line widget
                  
                ],
              ),
            );
          })
    );
  }
}


//BobaOrder(bobaCart: bobaCart),
class BobaOrder extends StatelessWidget {
  const BobaOrder({
    Key key,
    @required this.bobaCart,
    @required this.index
  }) : super(key: key);

  final BobaCartModel bobaCart;
  final int index;

  int getOrderCount(){
    bobaCart.bobaOrders.forEach((element) {
      print(element.bobaProductName);
    });
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "${bobaCart.bobaOrders[index].bobaProductName.toUpperCase()} MILK TEA",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                  wordSpacing: 3,
                  letterSpacing: 2,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${bobaCart.bobaOrders[index].milkTypeName}",
//                                "${bobaCart.bobaOrders[0].sweetnessLevelName} \n"
//                                "${bobaCart.bobaOrders[0].iceLevelName} \n",

                          style: TextStyle(
                              color: Colors.white30,
                              fontSize: 15
                          ),
                        ),
                        Text(
                          "${bobaCart.bobaOrders[index].sweetnessLevelName}",
                          style: TextStyle(
                              color: Colors.white30,
                              fontSize: 15
                          ),
                        ),
                        Text(
                          "${bobaCart.bobaOrders[index].iceLevelName}",
                          style: TextStyle(
                              color: Colors.white30,
                              fontSize: 15
                          ),
                        ),
                        Text(
                          bobaCart.bobaOrders[index].toppingsName == null ? "No Toppings"
                              : "${bobaCart.bobaOrders[index].toppingsName}",
                          style: TextStyle(
                            color: Colors.white30,
                            fontSize: 15
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0, left: 12),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                child: Text(
                                  "EDIT",
                                  style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                child: Text(
                                    "REMOVE",
                                  style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
//                    ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "QTY",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                              alignment: Alignment.center,
                            ),
                          ],
//                            crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pinkAccent,
                                  fontSize: 37
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              alignment: Alignment.center,
                              child: Text(
//                                "${bobaCart.orderCount}",
                                  getOrderCount().toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 37
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white30
                              ),
                            ),
                            Text(
                              "+",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pinkAccent,
                                  fontSize: 37
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )
                      ],
                    ),
//                    ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
