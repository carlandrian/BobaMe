import 'package:flutter/material.dart';

import 'boba_order_model.dart';

class BobaCartModel extends ChangeNotifier {
  final List<BobaOrderModel> _bobaOrderList = [];


  void addOrder(BobaOrderModel order) {
    _bobaOrderList.add(order);
    notifyListeners();
  }

  int get orderCount => _bobaOrderList.length;
}