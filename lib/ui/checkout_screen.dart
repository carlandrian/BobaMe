import 'package:boba_me/model/boba_cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  ScrollController _scrollController;
  bool _nextButtonEnabled = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if(_scrollController.offset >= _scrollController.position.maxScrollExtent &&
      !_scrollController.position.outOfRange) {
        setState(() {
          _nextButtonEnabled = true;
        });
      }

      if(_scrollController.position.atEdge){
        print("atEdge");
      }


      if(!_scrollController.position.haveDimensions){
        setState(() {
          _nextButtonEnabled = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bobaCart = Provider.of<BobaCartModel>(context);

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
        controller: _scrollController,
        itemCount: bobaCart.bobaOrdersMap.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Column(
              children: <Widget>[
                BobaOrder(bobaCart: bobaCart, index: index,),
                // add line widget
//                  Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 15.0),
//                    child: Container(
//                      color: Colors.white12,
//                      child: SizedBox(
//                        height: 2,
//                        width: MediaQuery.of(context).size.width,
//                      ),
//                    ),
//                  )
              ],
            ),
          );
        },
        physics: BouncingScrollPhysics(),
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
                onPressed: _nextButtonEnabled || (bobaCart.bobaOrdersMap.length < 3)? () {
                } : null,
              )
            ],
          ),
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    String key = bobaCart.bobaOrdersMap.keys.elementAt(index);
    int totalOrderSize = bobaCart.bobaOrdersMap.keys.length;
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${bobaCart.bobaOrdersMap[key].bobaProductName.toString().trim().toUpperCase()} MILK TEA",
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
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "${bobaCart.bobaOrdersMap[key].milkTypeName}",
                              style: TextStyle(
                                  color: Colors.white30,
                                  fontSize: 15
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:4.0),
                            child: Text(
                              "${bobaCart.bobaOrdersMap[key].sweetnessLevelName}",
                              style: TextStyle(
                                  color: Colors.white30,
                                  fontSize: 15
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "${bobaCart.bobaOrdersMap[key].iceLevelName}",
                              style: TextStyle(
                                  color: Colors.white30,
                                  fontSize: 15
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              bobaCart.bobaOrdersMap[key].toppingsName.toString().isEmpty ? "No Toppings"
                                  : "${bobaCart.bobaOrdersMap[key].toppingsName}",
                              style: TextStyle(
                                color: Colors.white30,
                                fontSize: 15
                              ),
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
                                    bobaCart.bobaOrdersMap[key].orderCount.toString(),
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
                    )
                  ],
                )
              ],
            ),
            // price details here
            Container(
              child: totalOrderSize-1 == index ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Container(
                      color: Colors.white12,
                      child: SizedBox(
                        height: 2,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "Subtotal ..............................${bobaCart.subTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white30,
                        letterSpacing: 2
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "Taxes ..................................${bobaCart.taxes.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white30,
                          letterSpacing: 2
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "Delivery Fee .........................${bobaCart.deliveryFee.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white30,
                          letterSpacing: 2
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "Order Total ........................... ${bobaCart.orderTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 2
                      ),
                    ),
                  ),
                ],
              ) : Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  color: Colors.white12,
                  child: SizedBox(
                    height: 2,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ),
//            totalOrderSize-1 == index ? Container(
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  RaisedButton(
//                    child: Text(
//                      "Cancel",
//                      style: TextStyle(
//                          fontSize: 16,
//                          color: Colors.white,
//                          letterSpacing: 2
//                      ),
//                    ),
//                  ),
//                  RaisedButton(
//                    child: Text(
//                      "Next",
//                      style: TextStyle(
//                          fontSize: 16,
//                          color: Colors.white,
//                          letterSpacing: 2
//                      ),
//                    ),
//                  )
//                ],
//              ),
//            ) : Container(),
          ],
        ),
      ),
    );
  }
}
