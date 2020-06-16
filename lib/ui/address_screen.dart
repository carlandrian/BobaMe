import 'package:boba_me/ui/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController firstNameController;
  TextEditingController addressLine1Controller;
  TextEditingController addressLine2Controller;
  TextEditingController cityTownController;
  TextEditingController provinceController;
  TextEditingController phoneNumberController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    addressLine1Controller = TextEditingController();
    addressLine2Controller = TextEditingController();
    cityTownController = TextEditingController();
    cityTownController.value = TextEditingValue(text: "STA. CRUZ");
    provinceController = TextEditingController();
    provinceController.value = TextEditingValue(text: "LAGUNA");
    phoneNumberController = TextEditingController();
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
            children: <Widget>[
              BobaTextfield(
                textFieldLabel: "CUSTOMER NAME",
                inputController: firstNameController,
                enabled: true,
              ),
              BobaTextfield(
                textFieldLabel: "ADDRESS LINE 1",
                inputController: addressLine1Controller,
                enabled: true,
              ),
              BobaTextfield(
                textFieldLabel: "ADDRESS LINE 2",
                inputController: addressLine2Controller,
                enabled: true,
              ),
              BobaTextfield(
                textFieldLabel: "CITY/TOWN",
                inputController: cityTownController,
                enabled: false,
              ),
              BobaTextfield(
                textFieldLabel: "PROVINCE",
                inputController: provinceController,
                enabled: false,
              ),
              BobaTextfield(
                textFieldLabel: "PHONE NUMBER",
                inputController: phoneNumberController,
                enabled: true,
              ),
            ],
        ),
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
