import 'package:boba_me/ui/product_add_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'custom_widgets/custom_widgets.dart';



class ProductScreen extends StatefulWidget {
  static const String id = "product_screen";
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _auth = FirebaseAuth.instance;
  var bobaProductsDb = Firestore.instance.collection('BobaProducts').snapshots();

  @override
  void initState() {
    super.initState();
    isCurrentUserLoggedIn();
  }


  
  @override
  Widget build(BuildContext context) {
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
              }
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
                  child: Image.asset("images/shopping_cart_icon.png"),
                  onTap: () {
                    print('shopping cart clicked');
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
      print("user is logged in");
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
//                  _showAddOrderDialog(context);
//                    Navigator.pushNamed(context, ProductAddScreen.id);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProductAddScreen(bobaProductName: firebaseDocument['name'].toString()),
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
