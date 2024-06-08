import 'dart:convert';
import 'dart:developer';

import 'package:covefood_domiciliario/constant/constant.dart';
import 'package:covefood_domiciliario/controller/provider/profileProvider/profileProvider.dart';
import 'package:covefood_domiciliario/model/driverModel/driverModel.dart';
import 'package:covefood_domiciliario/model/foodOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  static updateDriverProfileIntoFoodOrderModel(
      String orderID, BuildContext context) async {
    DriverModel delieveryPartnerData =
        context.read<ProfileProvider>().driverProfile!;
    realTimeDatabaseRef
        .child('Orders/$orderID/delieveryPartnerData')
        .set(delieveryPartnerData.toMap());
    realTimeDatabaseRef
        .child('Driver/${auth.currentUser!.uid}/activeDelieveryRequestID')
        .set(orderID);
  }

  static orderStatus(int status) {
    switch (status) {
      case 0:
        return 'PREPARANDO_COMIDA';
      case 1:
        return 'COMIDA_RECOGIDA_POR_DOMICILIARIO';
      case 2:
        return 'COMIDA_ENTREGADA';
    }
  }
}
