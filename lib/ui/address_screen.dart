import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text(
          "ADDRESS",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 3,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "FIRST NAME"
            ),
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text(
                "CANCEL",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            RaisedButton(
              child: Text(
                "NEXT",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
