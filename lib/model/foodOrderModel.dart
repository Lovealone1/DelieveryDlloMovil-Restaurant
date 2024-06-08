import 'dart:convert';

import 'package:covefood_domiciliario/model/driverModel/driverModel.dart';
import 'package:covefood_domiciliario/model/foodModel.dart';
import 'package:covefood_domiciliario/model/restaurantModel.dart';
import 'package:covefood_domiciliario/model/userAddressModel.dart';
import 'package:covefood_domiciliario/model/userModel.dart';


class FoodOrderModel {
  FoodModel foodDetails;
  RestaurantModel restaurantDetails;
  UserAddressModel? userAddress;
  UserModel? userData;
  DriverModel? delieveryPartnerData;
  String? orderID;
  String? orderStatus;
  String restaurantUID;
  String userUID;
  DateTime? addedToCartAt;
  DateTime? orderPlacedAt;
  DateTime? orderDelieveredAt;
  int? quantity;

  FoodOrderModel({
    required this.foodDetails,
    required this.restaurantDetails,
    required this.userAddress,
    required this.userData,
    this.delieveryPartnerData,
    required this.orderID,
    required this.orderStatus,
    required this.restaurantUID,
    required this.userUID,
    this.addedToCartAt,
    required this.orderPlacedAt,
    this.orderDelieveredAt,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foodDetails': foodDetails.toMap(),
      'restaurantDetails': restaurantDetails.toMap(),
      'userAddress': userAddress?.toMap(),
      'userData': userData?.toMap(),
      'delieveryPartnerData': delieveryPartnerData?.toMap(),
      'orderID': orderID,
      'orderStatus': orderStatus,
      'restaurantUID': restaurantUID,
      'userUID' : userUID,
      'addedToCartAt': addedToCartAt?.millisecondsSinceEpoch, // Convert to milliseconds
      'orderPlacedAt': orderPlacedAt?.millisecondsSinceEpoch, // Convert to milliseconds
      'orderDelieveredAt': orderDelieveredAt?.millisecondsSinceEpoch, // Convert to milliseconds
      'quantity': quantity,
    };
  }

  factory FoodOrderModel.fromMap(Map<String, dynamic> map) {
    return FoodOrderModel(
      foodDetails: FoodModel.fromMap(map['foodDetails'] as Map<String, dynamic>),
      restaurantDetails: RestaurantModel.fromMap(map['restaurantDetails'] as Map<String, dynamic>),
      userAddress: map['userAddress'] != null ? UserAddressModel.fromMap(map['userAddress'] as Map<String, dynamic>) : null,
      userData: map['userData'] != null ? UserModel.fromMap(map['userData'] as Map<String, dynamic>) : null,
      delieveryPartnerData: map['delieveryPartnerData'] != null ? DriverModel.fromMap(map['delieveryPartnerData'] as Map<String, dynamic>) : null,
      orderID: map['orderID'] != null ? map['orderID'] as String : null,
      orderStatus: map['orderStatus'] != null ? map['orderStatus'] as String : null,
      restaurantUID: map['restaurantUID'] as String,
      userUID: map['userUID'] as String,
      addedToCartAt: map['addedToCartAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['addedToCartAt'] as int) : null,
      orderPlacedAt: map['orderPlacedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['orderPlacedAt'] as int) : null,
      orderDelieveredAt: map['orderDelieveredAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['orderDelieveredAt'] as int) : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodOrderModel.fromJson(String source) => FoodOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
