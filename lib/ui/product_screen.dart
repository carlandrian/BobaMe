import 'package:boba_me/model/boba_cart_model.dart';
import 'package:boba_me/model/boba_order_model.dart';
import 'package:boba_me/ui/checkout_screen.dart';
import 'package:boba_me/ui/product_add_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'custom_widgets/custom_widgets.dart';

class ProductScreen extends StatefulWidget {
  static const String id = "product_screen";
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _auth = FirebaseAuth.instance;
  var bobaProductsDb = Firestore.instance.collection('BobaProducts').snapshots();
//  var _orderCount = 0;


  @override
  void initState() {
    super.initState();
    isCurrentUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    var bobaCartModel = Provider.of<BobaCartModel>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: BobaBannerImage(),
      ),
      body: StreamBuilder(
        stream: bobaProductsDb,
        builder: (context, snapshots) {
          if(!snapshots.hasData) return CircularProgressIndicator();

          return ListView.builder(
              itemCount: snapshots.data.documents.length,
              itemBuilder: (context, int index) {
                  return Container(
                    child: FutureBuilder(
                      future: _getProducts(context, snapshots.data.documents[index]),//_getFirebaseImage(snapshots.data.documents[index]['imageId']),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 1.85,
                            width: MediaQuery.of(context).size.width,
                            child: snapshot.data,
                          );
                        }

                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 1.85,
                            width: MediaQuery.of(context).size.width,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                            ),
                          );
                        }
                      },
                    ),
                  );
              },
            physics: BouncingScrollPhysics(),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  child: Image.asset("images/boba_profile_icon.png"),
                  onTap: () {
                    print('profile clicked');
                  },
              ),
              InkWell(
                  child: Image.asset("images/boba_drink_icon.png"),
                  onTap: () {
                    print('shop clicked');
                  },
              ),
              InkWell(
                  child: bobaCartModel.orderCount > 0 ? ShoppingCartWithCount(count: bobaCartModel.orderCount) : Image.asset("images/shopping_cart_icon.png"),
                  onTap: () {
                    if(bobaCartModel.orderCount > 0) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CheckoutScreen(),
                      ));
                    }
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void isCurrentUserLoggedIn() async {
    final currentUser = await _auth.currentUser();
    if(currentUser != null) {
      print("${currentUser.uid} is logged in");
//      bobaOrder.customerInfoId = currentUser.uid;
    }else{

    }
  }

  @override
  void dispose() {
    super.dispose();
    _auth.signOut();
    print("user has signed-out");
  }
}

//class ShoppingCartWithCount extends StatefulWidget {
//  final int count;
//  ShoppingCartWithCount({this.count});
//  @override
//  _ShoppingCartWithCountState createState() => _ShoppingCartWithCountState();
//}
//
//class _ShoppingCartWithCountState extends State<ShoppingCartWithCount> {
//  final int count;
//  int counter;
//  _ShoppingCartWithCountState({this.count});
//
//  refresh(){
//    setState(() {
//      counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      alignment: Alignment.topRight,
//      children: <Widget>[
//        Image.asset("images/shopping_cart_icon.png"),
//        Container(
//          height: 21,
//          width: 21,
//          decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color: Colors.pinkAccent
//          ),
//          child: Text(
//            bobaOrder.orderCount.toString(),
//            textAlign: TextAlign.center,
//            style: TextStyle(
//                color: Colors.white,
//                fontSize: 15,
//                fontWeight: FontWeight.bold
//            ),
//          ),
//        )
//      ],
//    );
//  }
//}

class ShoppingCartWithCount extends StatelessWidget {
  final int count;
  const ShoppingCartWithCount({
    Key key, this.count,
  }) : super(key: key);

  refresh(){
    setState(){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
          Image.asset("images/shopping_cart_icon.png"),
          Container(
            height: 21,
            width: 21,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pinkAccent
            ),
            child: Text(
                count.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
            ),
          )
      ],
    );
  }
}

Future<Widget> _getFirebaseImage(url) async {
  Image m;
  await FirebaseStorage.instance.ref().child(url).getDownloadURL().then((value) => {
    m = Image.network(
      value.toString()
    )
  });

  return m;
}

Future<Widget> _getProducts(context, firebaseDocument) async {
  Image productImage;
  await FirebaseStorage.instance.ref().child(firebaseDocument['imageId']).getDownloadURL()
  .then((value) => {
    productImage = Image.network(value.toString())
  });

  // put the image and its name, text and price in a stack
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      productImage,
      Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.58,
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 12.5,
              ),
              Text(
                firebaseDocument['name'].toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height / 6.5,
                child: Text(
                  "${firebaseDocument['description'].toString()}\n\n"
                      "Php ${double.parse(firebaseDocument['price'].toString()).toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/12.5,
              ),
              InkWell(
                child: Text(
                  "ADD",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 29
                  ),
                ),
                onTap: () {
                  print("Add ${firebaseDocument['name'].toString()} to cart");
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProductAddScreen(
                        bobaProductName: firebaseDocument['name'].toString(),
                        bobaProductPrice: firebaseDocument['price']
                      ),
                    ));
                },
              )
            ],
          ),
        ],
      ),
    ],
  );
}

_showAddOrderDialog(BuildContext context) async {
  var _dropDownValue = 'Milk';
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: DropdownButton(
          value: _dropDownValue,
          items: ['Milk', 'Soya', 'Fresh'].map((e) => DropdownMenuItem(
            child: Text(e),
            value: e,
          )).toList(),
          onChanged: (value) {
            print(value);
            _dropDownValue = value;
          },
        ),
        actions: <Widget>[
          new RaisedButton(
              child: Text("Add"),
              onPressed: (){

              }
          )
        ],
      );
    }
  );
}
