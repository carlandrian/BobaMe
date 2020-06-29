import 'package:boba_me/model/boba_cart_model.dart';
import 'package:boba_me/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_widgets/custom_widgets.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BobaCartModel bobaCartModel = Provider.of<BobaCartModel>(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ButtonSwitchBanner(
            button1Text: "PROFILE",
            button2Text: "ORDERS",
            button1Highlighted: false,
            button2Highlighted: true,
            button1DestScreenWidget: ProfileScreen(),
            button2DestScreenWidget: null,
          ),
        ],
      ),
      bottomNavigationBar: BobaNavigationBar(
        bobaCartModel: bobaCartModel,
      ),
    );
  }
}
