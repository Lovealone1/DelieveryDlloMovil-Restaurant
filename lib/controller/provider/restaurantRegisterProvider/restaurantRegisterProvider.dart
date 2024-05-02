import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delievery_restaurants/controller/services/imageServices/imagesServices.dart';
import 'package:food_delievery_restaurants/controller/services/restaurantCRUDServices/restaurantCrudServices.dart';
import 'package:food_delievery_restaurants/models/restaurantModel.dart';

class RestaurantRegisterProvider extends ChangeNotifier {
  List<File> restaurantBannerImages = [];
  List<String> restaurantBannerImagesURL = [];
  RestaurantModel? restaurantData;
  getRestaurantBannerImages(BuildContext context) async {
    restaurantBannerImages =
        await ImageServices.getImagesFromGallery(context: context);
    notifyListeners();
  }

  updateRestaurantBannerImagesURL(BuildContext context) async {
    restaurantBannerImagesURL =
        await ImageServices.uploadImagesToFirebaseStorageNGetURL(
            images: restaurantBannerImages, context: context);
    notifyListeners();
  }

  getRestaurantData()async { 
    restaurantData = await RestaurantCRUDServices.fetchRestaurantData();
    notifyListeners();
  }
}
