import 'package:flutter/material.dart';

import 'boba_order_model.dart';

class BobaCartModel extends ChangeNotifier {
  final List<BobaOrderModel> _bobaOrderList = [];
  final Map _bobaOrderMap = Map<String, dynamic>();

  void addOrderToMap(BobaOrderModel order) {
    _bobaOrderMap.putIfAbsent(order.bobaProductName, () => order);
  }

  void addOrderToList(BobaOrderModel order) {
    print("order.milkTypeName: ${order.milkTypeName}");
    _bobaOrderList.add(order);

    notifyListeners();
  }
  List<BobaOrderModel> get bobaOrders => _bobaOrderList;
  
  int get orderCount => _bobaOrderList.length;
  int get orderCountMap => _bobaOrderMap.length;
}