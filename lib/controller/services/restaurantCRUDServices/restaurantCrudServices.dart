import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delievery_restaurants/constant/constant.dart';
import 'package:food_delievery_restaurants/models/restaurantModel.dart';
import 'package:food_delievery_restaurants/view/signInLogicScreen/signInLoginScreen.dart';
import 'package:page_transition/page_transition.dart';

class RestaurantCRUDServices {
  static registerRestaurant(RestaurantModel data, BuildContext context) async {
    try {
      await firestore
          .collection('Restaurant')
          .doc(auth.currentUser!.uid)
          .set(data.toMap())
          .whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const SignInLogicScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static fetchRestaurantData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Restaurant')
          .doc(auth.currentUser!.uid)
          .get();
      RestaurantModel data = RestaurantModel.fromMap(snapshot.data()!);
      return data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
