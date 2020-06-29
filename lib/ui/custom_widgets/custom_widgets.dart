import 'package:boba_me/ui/login_screen.dart';
import 'package:flutter/material.dart';

import '../sign_up_screen.dart';


class BobaBannerImage extends StatelessWidget {
  const BobaBannerImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(
          "images/bobame_black_white_on_bbg.png"
      ),
    );
  }
}


class ButtonSwitchBanner extends StatelessWidget {
  final String button1Text;
  final String button2Text;
  final bool button1Highlighted;
  final bool button2Highlighted;


  const ButtonSwitchBanner({
    Key key,
    @required this.button1Text,
    @required this.button2Text,
    this.button1Highlighted,
    this.button2Highlighted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              InkWell(
                child: Text(
                  button1Text,
                  style: TextStyle(
                    fontSize: 21,
                    color: button1Highlighted ? Colors.white : Colors.white30,
                  ),
                ),
                onTap: () {
//                  print("Login tapped");
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              Hero(
                tag: "pinkLine",
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
                  child: Container(
                    height: 10,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: button1Highlighted ? Colors.pinkAccent : Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              InkWell(
                child: Text(
                  button2Text,
                  style: TextStyle(
                    fontSize: 21,
                    color: button2Highlighted ? Colors.white : Colors.white30,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, SignupScreen.id);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
                child: Container(
                  height: 10,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: button2Highlighted ? Colors.pinkAccent : Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class BobaTextfield extends StatelessWidget {

  final TextEditingController inputController;
  final String textFieldLabel;
  final bool enabled;
  final double fontSize;
  final Function onChanged;

  const BobaTextfield({
    Key key,
    @required this.inputController, @required this.textFieldLabel, this.enabled, this.fontSize, this.onChanged,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      keyboardType: (textFieldLabel=="EMAIL") ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
          labelText: textFieldLabel,
          labelStyle: TextStyle(
            color: Colors.white30,
          ),
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
      ),
      enabled: enabled,
      onChanged: onChanged,
    );
  }
}

class ErrorAlertDialog extends StatelessWidget {
  final String contentText;

  const ErrorAlertDialog({Key key, this.contentText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "BobaMe - Error"
      ),
      content: Text(
        "$contentText"
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text(
            "OK"
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
