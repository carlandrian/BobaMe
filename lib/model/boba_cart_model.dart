import 'package:flutter/material.dart';

import 'boba_order_model.dart';

class BobaCartModel extends ChangeNotifier {
  final Map _bobaOrderMap = Map<String, dynamic>();
//  double _taxes = 0.00;
  double _tax = 0.12;
//  double _subTotal = 0.00;
  double _deliveryFee = 10.0;
//  double _orderTotal = 0.00;


  void addOrderToMap(BobaOrderModel order) {
    String key = order.bobaProductName + order.milkTypeName + order.sweetnessLevelName
        + order.iceLevelName + order.toppingsName;

    if(_bobaOrderMap.containsKey(key)) {
      BobaOrderModel updateOrder = _bobaOrderMap[key];
      updateOrder.orderCount = updateOrder.orderCount + 1;
      _bobaOrderMap[key] = updateOrder;
    }else{
      _bobaOrderMap.putIfAbsent(
          order.bobaProductName + order.milkTypeName + order.sweetnessLevelName
              + order.iceLevelName + order.toppingsName,
              () => order);
    }

    notifyListeners();
  }

  Map<String, dynamic> get bobaOrdersMap => _bobaOrderMap;
  
  int get orderCount {
    int orderCount = 0;
    _bobaOrderMap.forEach((key, value) {
      BobaOrderModel updateOrder = _bobaOrderMap[key];
      orderCount = orderCount + updateOrder.orderCount;
    });
    return orderCount;
  }

  int get orderCountMap => _bobaOrderMap.length;

  double get taxes {
    double ordTotal = 0;
    int orderNumber = 0;
    _bobaOrderMap.forEach((key, value) {
      BobaOrderModel updateOrder = _bobaOrderMap[key];
      orderNumber = updateOrder.orderCount;
      ordTotal += (updateOrder.price*orderNumber);
    });

    return ordTotal * _tax;
  }

  double get subTotal {
    double ordTotal = 0;
    int orderNumber = 0;
    _bobaOrderMap.forEach((key, value) {
      BobaOrderModel updateOrder = _bobaOrderMap[key];
      orderNumber = updateOrder.orderCount;
      ordTotal += (updateOrder.price*orderNumber);
    });

    double taxMultiplier = 1.00 - _tax;
    return ordTotal * taxMultiplier;
  }

  double get orderTotal {
    double ordTotal = 0;
    int orderNumber = 0;
    _bobaOrderMap.forEach((key, value) {
      BobaOrderModel updateOrder = _bobaOrderMap[key];
      orderNumber = updateOrder.orderCount;
      ordTotal += (updateOrder.price*orderNumber);
    });
    ordTotal += _deliveryFee;
    return ordTotal;
  }

  double get deliveryFee {
    return _deliveryFee;
  }
}