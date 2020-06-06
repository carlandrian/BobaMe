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
  final int bobaProductPrice;

  const ProductAddScreen({Key key, this.bobaProductName, this.bobaProductPrice}) : super(key: key);

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState(bobaName: bobaProductName, bobaPrice: bobaProductPrice);
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final String bobaName;
  final int bobaPrice;

  _ProductAddScreenState({this.bobaName, this.bobaPrice});
  FirebaseAuth _auth = FirebaseAuth.instance;
  var iceLevelDb = Firestore.instance.collection('IceLevel').snapshots();
  var milkTypeDb = Firestore.instance.collection('MilkType').snapshots();
  var sweetnessDb = Firestore.instance.collection('SweetnessLevel').snapshots();
  var toppingsDb = Firestore.instance.collection('Toppings').snapshots();
  int _totalPrice;
  String _milkType;
  String _sweetness;
  String _iceLevel;
  String _topping;

  List<RadioModel> toppingsRadioList = List<RadioModel>();


  @override
  void initState() {
    super.initState();
    print("getToppings()");
//    getToppings();
    toppingsRadioList.add(RadioModel(false, "Small Tapioca", "Small Tapioca"));
    toppingsRadioList.add(RadioModel(false, "Large Tapioca", "Large Tapioca"));
    toppingsRadioList.add(RadioModel(false, "Lychee Jelly", "Lychee Jelly"));
    print("Toppings added");
  }

//  void getToppings() {
//    print("getToppings()");
//    toppingsDb.listen((event) {
//      event.documents.forEach((element) {
//        print(element.data['name']);
//        toppingsRadioList.add(
//            RadioModel(
//              false,element.data['name'],element.data['name']
//            )
//        );
//      });
//    });
//  }

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

              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Text(
                  "Tap to select toppings",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            // Toppings radio buttons here
              Padding(
                padding: const EdgeInsets.only(right: 50.0, left: 50.0, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
  //                  FutureBuilder(
  //                    future: getRadioButtonToppingWidget(context, toppingsRadioList, 0),
  //                    builder: (context, snapshot) {
  //                      if(snapshot.connectionState == ConnectionState.done){
  //                        return snapshot.data;
  //                      }
  //
  //                      if(snapshot.connectionState == ConnectionState.waiting) {
  //                        return Container(
  //                          height: 5,
  //                          width: 5,
  //                          child: CircularProgressIndicator(
  //                            valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
  //                          ),
  //                        );
  //                      }
  //                    },
  //                  ),
  //                  FutureBuilder(
  //                    future: getRadioButtonToppingWidget(context, toppingsRadioList, 1),
  //                    builder: (context, snapshot) {
  //                      if(snapshot.connectionState == ConnectionState.done){
  //                        return snapshot.data;
  //                      }
  //
  //                      if(snapshot.connectionState == ConnectionState.waiting) {
  //                        return Container(
  //                          height: 5,
  //                          width: 5,
  //                          child: CircularProgressIndicator(
  //                            valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
  //                          ),
  //                        );
  //                      }
  //                    },
  //                  ),
  //                  FutureBuilder(
  //                    future: getRadioButtonToppingWidget(context, toppingsRadioList, 2),
  //                    builder: (context, snapshot) {
  //                      if(snapshot.connectionState == ConnectionState.done){
  //                        return snapshot.data;
  //                      }
  //
  //                      if(snapshot.connectionState == ConnectionState.waiting) {
  //                        return Container(
  //                          height: 5,
  //                          width: 5,
  //                          child: CircularProgressIndicator(
  //                            valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
  //                          ),
  //                        );
  //                      }
  //                    },
  //                  ),

                    InkWell(
                      child: CustomRadioItem(toppingsRadioList[0]),
                      borderRadius: BorderRadius.circular(100),
                      highlightColor: Colors.pinkAccent,
                      onTap: () {
                          setState(() {
                            if(toppingsRadioList[0].isSelected) {
                              toppingsRadioList[0].isSelected = false;
                            }else {
                              toppingsRadioList.forEach((element) =>
                              element.isSelected = false);
                              toppingsRadioList[0].isSelected = true;
                            }
                          });
                        },
                    ),
                    InkWell(
                      child: CustomRadioItem(toppingsRadioList[1]),
                      borderRadius: BorderRadius.circular(100),
                      highlightColor: Colors.pinkAccent,
                      onTap: () {
                        setState(() {
                          if(toppingsRadioList[1].isSelected) {
                            toppingsRadioList[1].isSelected = false;
                          }else {
                            toppingsRadioList.forEach((element) =>
                            element.isSelected = false);
                            toppingsRadioList[1].isSelected = true;
                          }
                        });
                      },
                    ),
                    InkWell(
                      child: CustomRadioItem(toppingsRadioList[2]),
                      borderRadius: BorderRadius.circular(100),
                      highlightColor: Colors.pinkAccent,
                      onTap: () {
                        setState(() {
                          if(toppingsRadioList[2].isSelected) {
                            toppingsRadioList[2].isSelected = false;
                          }else {
                            toppingsRadioList.forEach((element) =>
                            element.isSelected = false);
                            toppingsRadioList[2].isSelected = true;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),

              // Total Price
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "TOTAL:",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.white30,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Php ${bobaPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: RaisedButton(
                  onPressed: () {
                    print("Add");
                  },
                  child: Text(
                    "     ADD     ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19
                    ),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<Widget> getRadioButtonToppingWidget(context, radioModelList, index) async {
    return InkWell(
      child: CustomRadioItem(radioModelList[index]),
      borderRadius: BorderRadius.circular(100),
      highlightColor: Colors.pinkAccent,
      onTap: () {
        setState(() {
          print(index);
          if(radioModelList[index].isSelected) {
            radioModelList[index].isSelected = false;
          }

          radioModelList.forEach((element) => element.isSelected = false);
          radioModelList[index].isSelected = true;

        });
      },
    );
  }

}



class CustomRadioItem extends StatelessWidget {
  final RadioModel _radioModel;

  const CustomRadioItem(this._radioModel);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
//          fit: StackFit.expand,  // this will cause an error during run
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              child: Center(
                child: Text(
                  "${_radioModel.buttonLabel.split(" ").elementAt(0)}\n${_radioModel.buttonLabel.split(" ").elementAt(1)}",
                  style: TextStyle(

                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: _radioModel.isSelected ? Colors.pinkAccent : Colors.black,
//                  color: Colors.pinkAccent,
                  border: Border.all(
                    color: Colors.pinkAccent,
                    width: 2,
                    style: BorderStyle.solid,
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonLabel;
  final String value;

  RadioModel(this.isSelected, this.buttonLabel, this. value);
}