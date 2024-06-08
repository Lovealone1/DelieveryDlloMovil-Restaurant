import 'dart:convert';
import 'dart:developer';

import 'package:covefood_domiciliario/constant/constant.dart';
import 'package:covefood_domiciliario/model/foodOrderModel.dart';

class OrderServices {
  static fetchOrderDetails(String orderID) async {
    try {
      var snapshot = await realTimeDatabaseRef.child('Orders/$orderID').get();
      FoodOrderModel foodData = FoodOrderModel.fromMap(
          jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>);
          return foodData;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
