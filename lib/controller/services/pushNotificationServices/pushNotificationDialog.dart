// ignore_for_file: use_build_context_synchronously

import 'package:covefood_domiciliario/constant/constant.dart';
import 'package:covefood_domiciliario/controller/services/orderServices/orderServices.dart';
import 'package:covefood_domiciliario/model/foodOrderModel.dart';
import 'package:covefood_domiciliario/utils/colors.dart';
import 'package:covefood_domiciliario/utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:sizer/sizer.dart';

class PushNotificationDialog {
  static delieveryRequestDialog(String orderID, BuildContext context) async {
    audioPlayer.setAsset('assets/sounds/alert.mp3');
    audioPlayer.play();

    FoodOrderModel foodOrderData =
        await OrderServices.fetchOrderDetails(orderID);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 50.h,
              width: 90.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Solicitud de domicilio',
                      style: AppTextStyles.body16Bold,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Direccion de recogida: \t',
                              style: AppTextStyles.body14Bold),
                          TextSpan(
                              text: foodOrderData
                                  .restaurantDetails.restaurantName,
                              style: AppTextStyles.body14),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Dirección de entrega: \t',
                              style: AppTextStyles.body14Bold),
                          TextSpan(
                              text: foodOrderData.userAddress!.apartment,
                              style: AppTextStyles.body14),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SwipeButton(
                      thumbPadding: EdgeInsets.all(1.w),
                      thumb: Icon(Icons.chevron_right, color: white),
                      inactiveThumbColor: black,
                      activeThumbColor: black,
                      inactiveTrackColor: Color.fromRGBO(255, 117, 107, 1),
                      activeTrackColor: Color.fromRGBO(255, 117, 107, 1),
                      elevationThumb: 2,
                      elevationTrack: 2,
                      onSwipe: () {
                        audioPlayer.stop();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Rechazar',
                        style: AppTextStyles.body14Bold,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SwipeButton(
                      thumbPadding: EdgeInsets.all(1.w),
                      thumb: Icon(Icons.chevron_right, color: white),
                      inactiveThumbColor: black,
                      activeThumbColor: black,
                      inactiveTrackColor: Colors.green.shade200,
                      activeTrackColor: Colors.green.shade200,
                      elevationThumb: 2,
                      elevationTrack: 2,
                      onSwipe: () {
                        audioPlayer.stop();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Aceptar',
                        style: AppTextStyles.body14Bold,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
