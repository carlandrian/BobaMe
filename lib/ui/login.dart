import 'package:boba_me/ui/product.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'custom_widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  TextEditingController emailInputController;
  TextEditingController passwordInputController;
  var obscurePassword = true;
  var eyeIcon = FontAwesomeIcons.eye;
  @override
  void initState() {
    super.initState();
    emailInputController = TextEditingController();
    passwordInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            BobaBannerImage(),
            LoginSignUpBanner(loginHighlighted: true, signupHighlighted: false,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 44),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BobaTextfield(inputController: emailInputController, textFieldLabel: "EMAIL",),
                  TextField(
                    controller: passwordInputController,
                    decoration: InputDecoration(
                      labelText: "PASSWORD",
                      labelStyle: TextStyle(
                          color: Colors.white30
                      ),
                      suffixIcon: FlatButton(
                        child: Icon(
                          eyeIcon,
                          color: Colors.pinkAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                            if(obscurePassword){
                              eyeIcon = FontAwesomeIcons.eye;
                            }else{
                              eyeIcon = FontAwesomeIcons.eyeSlash;
                            }
                          });

                        },
                      ),
                    ),
                    obscureText: obscurePassword,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  onPressed: () async{
                    try {
                      final loginUser = await _auth.signInWithEmailAndPassword(email: emailInputController.text, password: passwordInputController.text);
                      if(loginUser != null) {
                        print("${loginUser.user.uid} is logged-in");
                        Navigator.pushNamed(context, ProductScreen.id);
                      }
                    }catch(e) {
                      print("error is ${e}");
                    }
                    setState(() {
                      print("password: ${passwordInputController.text}");

                    });
                  },
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19
                    ),
                  ),
//                    color: Colors.pinkAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}