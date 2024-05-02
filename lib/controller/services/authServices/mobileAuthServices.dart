import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_restaurants/constant/constant.dart';
import 'package:food_delievery_restaurants/controller/provider/authProvider/MobileAuthProvider.dart';
import 'package:food_delievery_restaurants/view/authScreens/mobileLoginScreen.dart';
import 'package:food_delievery_restaurants/view/authScreens/otpScreen.dart';
import 'package:food_delievery_restaurants/view/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:food_delievery_restaurants/view/restaurantRegistrationScreen/restaurantRegistrationScreen.dart';
import 'package:food_delievery_restaurants/view/signInLogicScreen/signInLoginScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MobileAuthServices {
  static checkRestaurantRegistration({required BuildContext context}) async {
    bool restaurantIsRegistered = false;
    try {
      await firestore
          .collection('Restaurant')
          .where('restaurantUID', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        value.size > 0
            ? restaurantIsRegistered = true
            : restaurantIsRegistered = false;
        log('El restaurante ya está registrado = $restaurantIsRegistered');
        if (restaurantIsRegistered) {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const BottomNavigationBarDelievery(),
                type: PageTransitionType.rightToLeft),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const RestaurantRegistrationScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false,
          );
        }
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static bool checkAuthentication(BuildContext context) {
    User? user = auth.currentUser;
    if (user == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MobileLoginScreen()),
          (route) => false);
      return false;
    }
    checkRestaurantRegistration(context: context);
    return true;
  }

  static recieveOTP(
      {required BuildContext context, required String mobileNo}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mobileNo,
        verificationCompleted: (PhoneAuthCredential credentials) {
          log(credentials.toString());
        },
        verificationFailed: (FirebaseAuthException exception) {
          log(exception.toString());
          throw Exception(exception);
        },
        codeSent: (String verificationID, int? resendToken) {
          context
              .read<MobileAuthProvider>()
              .updateVerificationID(verificationID);
          Navigator.push(
              context,
              PageTransition(
                  child: const OTPScreen(),
                  type: PageTransitionType.rightToLeft));
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static verifyOTP({required BuildContext context, required String otp}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: context.read<MobileAuthProvider>().verificationID!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      Navigator.push(
        context,
        PageTransition(
          child: const SignInLogicScreen(),
          type: PageTransitionType.rightToLeft,
        ),
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static signOut(BuildContext context){
    auth.signOut();
    Navigator.of(context , rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context){
      return const SignInLogicScreen();
    }), (route) => false);
  }
}
