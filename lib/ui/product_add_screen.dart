import 'package:boba_me/model/boba_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'custom_widgets/custom_widgets.dart';

var _dropDownValue = 'Milk';

class ProductAddScreen extends StatefulWidget {
  static const id = "ProductAddScreen";
  final String bobaProductName;

  const ProductAddScreen({Key key, this.bobaProductName}) : super(key: key);

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState(bobaName: bobaProductName);
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final String bobaName;
  _ProductAddScreenState({this.bobaName});
  FirebaseAuth _auth = FirebaseAuth.instance;
  var iceLevelDb = Firestore.instance.collection('IceLevel').snapshots();
  var milkTypeDb = Firestore.instance.collection('MilkType').snapshots();
  var sweetnessDb = Firestore.instance.collection('SweetnessLevel').snapshots();
  var toppingsDb = Firestore.instance.collection('Toppings').snapshots();
  String _milkType;
  String _sweetness;
  String _iceLevel;
  String _topping;


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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "How would you like your ${bobaName.trim()} Boba?",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                ),
              ),

              // Milk type drop-down
              StreamBuilder<QuerySnapshot>(
                  stream: milkTypeDb,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData) return Text("Loading...");
                    return new DropdownButton<String>(
                      iconSize: 40,
                      iconEnabledColor: Colors.pinkAccent,
                      focusColor: Colors.white,
//                      selectedItemBuilder: (context) {
//                        return snapshot.data.documents.map((map) => Text(map['name'].toString())).toList();
//                      },
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      value: _milkType,
                      items: snapshot.data.documents.map((map) {
                        return DropdownMenuItem<String>(
                          value: map['name'].toString(),
                          child: Text(
                            map['name'].toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Milk",
                        style: TextStyle(
                          color: Colors.white30,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _milkType = value;
                        });
                      },
                    );
                  }
                ),

              // Sweetness drop-down
              StreamBuilder<QuerySnapshot>(
                  stream: sweetnessDb,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData) return Text("Loading...");
                    return new DropdownButton<String>(
                      iconSize: 40,
                      iconEnabledColor: Colors.pinkAccent,
                      focusColor: Colors.white,
//                        selectedItemBuilder: (context) {
//                          return snapshot.data.documents.map((map) => Text(map['name'].toString())).toList();
//                        },
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      value: _sweetness,
                      items: snapshot.data.documents.map((map) {
                        return DropdownMenuItem<String>(
                          value: map['name'].toString(),
                          child: Text(
                            map['name'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Sweetness",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white30,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _sweetness = value;
                        });
                      },
                    );
                  }
              ),

              // Ice Level drop-down
              StreamBuilder<QuerySnapshot>(
                    stream: iceLevelDb,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(!snapshot.hasData) return Text("Loading...");
                      return new DropdownButton<String>(
                        iconSize: 40,
                        iconEnabledColor: Colors.pinkAccent,
                        focusColor: Colors.white,
//                        selectedItemBuilder: (context) {
//                          return snapshot.data.documents.map((map) => Text(map['name'].toString())).toList();
//                        },
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        value: _iceLevel,
                        items: snapshot.data.documents.map((map) {
                          return DropdownMenuItem<String>(
                            value: map['name'].toString(),
                            child: Text(
                              map['name'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                            ),
                          );
                        }).toList(),
                        hint: Text(
                            "Ice",
                              style: TextStyle(
                                color: Colors.white30,
                              ),
                          ),
                        onChanged: (value) {
                          setState(() {
                            _iceLevel = value;
                            print(value);
                          });
                        },
                      );
                    }
                ),

            Text(
              "Tap to select toppings",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            // Toppings radio buttons here
            Row(
              children: <Widget>[
//                CustomRadioItem(),
//                CustomRadioItem(),
              ],
            )
            ],
          ),
        ),
      ),
    );
  }
}

//class CustomRadioItem extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: Container(
//        child: Stack(
//          alignment: AlignmentDirectional.center,
//          fit: StackFit.expand,
//          children: <Widget>[
//            Container(
//              height: 50,
//              width: 50,
//              child: Center(
//                child: Text(
//                  "Larg\nTapioca",
//                  style: TextStyle(
//                    color: Colors.pinkAccent,
//                  ),
//                ),
//              ),
//              decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(50),
//                color: Colors.pinkAccent,
//                border: Border.all(
//                  color: Colors.pinkAccent,
//                  width: 2,
//                  style: BorderStyle.solid,
//                )
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
