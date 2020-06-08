import 'package:flutter/material.dart';

import 'boba_order_model.dart';

class BobaCartModel extends ChangeNotifier {
  final List<BobaOrderModel> _bobaOrderList = [];



  void addOrder(BobaOrderModel order) {
    print("order.milkTypeName: ${order.milkTypeName}");
    _bobaOrderList.add(order);

    notifyListeners();
  }
  List<BobaOrderModel> get bobaOrders => _bobaOrderList;
  
  int get orderCount => _bobaOrderList.length;
}