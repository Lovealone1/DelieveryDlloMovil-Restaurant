import 'dart:convert';
import 'dart:developer';

import 'package:covefood_domiciliario/controller/services/pushNotificationServices/pushNotificationDialog.dart';
import 'package:covefood_domiciliario/model/foodOrderModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:covefood_domiciliario/constant/constant.dart';
import 'package:flutter/material.dart';

class PushNotificationServices {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static Future initializeFirebaseMessaging(BuildContext context) async {
    await firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((
      RemoteMessage message,
    ) {
      if (message.notification != null) {
         log(message.toMap().toString());
         log('The message Data is ');
         log(message.data.toString());

        firebaseMessagingForegroundHandler(message, context);
      }
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
        log('Handling background message: ${message.notification?.title}');
      }

  static Future<void> firebaseMessagingForegroundHandler(
      RemoteMessage message, BuildContext context) async {
        try {
        log(message.data.toString());
        log(message.data['foodOrderID']);
        PushNotificationDialog.delieveryRequestDialog(message.data['foodOrderID'], context);
        } catch (e) {
          log(e.toString());
        }
      }

  static Future getToken() async {
    String? token = await firebaseMessaging.getToken();
    log('Token: \n$token');
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child('Driver/${auth.currentUser!.uid}/cloudMessagingToken');
    databaseReference.set(token);
  }
  static subscribeToNotification(){
    firebaseMessaging.subscribeToTopic('COVEFOOD_PARTNER');
  }

  static initializeFCM(BuildContext context){
    initializeFirebaseMessaging(context);
    getToken();
    subscribeToNotification();
  }
}
