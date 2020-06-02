import 'package:boba_me/model/boba_product.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        children: <Widget>[
          Text("How would you like your $bobaName?"),
          DropdownButton(
    
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
//              backgroundColor: Colors.black,
            ),
            icon: Icon(
                Icons.text_rotation_angledown
            ),
            value: _dropDownValue,
            items: ['Milk', 'Soya', 'Fresh'].map((e) => DropdownMenuItem(
              child: Text(e),
              value: e,
            )).toList(),
            onChanged: (value) {
              print(value);
              setState(() {
                _dropDownValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
