import 'package:boba_me/ui/login.dart';
import 'package:boba_me/ui/product.dart';
import 'package:boba_me/ui/sign_up.dart';
import 'package:boba_me/ui/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        buttonColor: Colors.pinkAccent,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.yellow,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.yellow,
          ),
          bodyText2: TextStyle(
            color: Colors.yellow,
          ),
        )
      ),
      initialRoute: LoginScreen.id,
//      home: SignupPage(),
//      home: LoginPage(),
      routes: {
        SignupScreen.id : (context) => SignupScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        ProductScreen.id : (context) => ProductScreen(),
      },
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

