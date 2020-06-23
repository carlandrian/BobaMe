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


class LoginSignUpBanner extends StatelessWidget {
  final bool loginHighlighted;
  final bool signupHighlighted;
  const LoginSignUpBanner({
    Key key, this.loginHighlighted, this.signupHighlighted,
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
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 21,
                    color: loginHighlighted ? Colors.white : Colors.white30,
                  ),
                ),
                onTap: () {
                  print("Login tapped");
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
                      color: loginHighlighted ? Colors.pinkAccent : Colors.black,
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
                  "SIGNUP",
                  style: TextStyle(
                    fontSize: 21,
                    color: signupHighlighted ? Colors.white : Colors.white30,
                  ),
                ),
                onTap: () {
                  print("Sign Up tapped");
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
                    color: signupHighlighted ? Colors.pinkAccent : Colors.black,
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
  const BobaTextfield({
    Key key,
    @required this.inputController, @required this.textFieldLabel, this.enabled, this.fontSize,
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
    );
  }
}