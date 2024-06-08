import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:covefood_domiciliario/constant/constant.dart';
import 'package:covefood_domiciliario/model/driverModel/driverModel.dart';
import 'package:covefood_domiciliario/view/signInLogicScreen/signInLoginScreen.dart';
import 'package:covefood_domiciliario/widgets/toastService.dart';
import 'package:page_transition/page_transition.dart';

class ProfileServices {
  static registerDriver(DriverModel driverData, BuildContext context) {
    realTimeDatabaseRef
        .child('Driver/${auth.currentUser!.uid}')
        .set(driverData.toMap())
        .then((value) {
      ToastService.sendScaffoldAlert(
        msg: 'Registro completado',
        toastStatus: 'SUCCESS',
        context: context,
      );
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const SignInLogicScreen(),
              type: PageTransitionType.rightToLeft),
          (route) => false);
    }).onError((error, stackTrace) {
      ToastService.sendScaffoldAlert(
        msg: 'Error al registrar',
        toastStatus: 'ERROR',
        context: context,
      );
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const SignInLogicScreen(),
              type: PageTransitionType.rightToLeft),
          (route) => false);
    });
  }

  static Future<bool> checkForRegistration() async {
    try {
      final snapshot = await realTimeDatabaseRef
          .child('Driver/${auth.currentUser!.uid}')
          .get();
      if (snapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static getDelieveryPartnerProfileData() async {
    try {
      final shapshot =
          await realTimeDatabaseRef.child('Driver/${auth.currentUser!.uid}').get();
      if (shapshot.exists) {
        DriverModel delieveryPartnerData = DriverModel.fromMap(
            jsonDecode(jsonEncode(shapshot.value)) as Map<String, dynamic>);
        return delieveryPartnerData;
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
