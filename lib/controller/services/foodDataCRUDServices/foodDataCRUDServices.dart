import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_restaurants/constant/constant.dart';
import 'package:food_delievery_restaurants/controller/services/toastServices/toastMessageService.dart';
import 'package:food_delievery_restaurants/models/addFoodModel/addFoodModel.dart';

class FoodDataCRUDServices {
  static uploadFoodData(BuildContext context, AddFoodModel data) async {
    try {
      await firestore
          .collection('Food')
          .doc(data.foodID)
          .set(data.toMap())
          .whenComplete(() {
        Navigator.pop(context);
        ToastService.sendScaffoldAlert(
          msg: 'Platillo agregado correctamente',
          toastStatus: 'SUCCESS',
          context: context,
        );
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static fetchFoodData() async {
    List<AddFoodModel> foodData = [];
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Food')
          .orderBy('uploadTime', descending: true)
          .where('restaurantUID', isEqualTo: auth.currentUser!.uid)
          .get();
      snapshot.docs.forEach((element) {
        foodData.add(AddFoodModel.fromMap(element.data()));
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
    return foodData;
  }
}
