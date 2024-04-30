import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delievery_restaurants/controller/services/imageServices/imagesServices.dart';

class RestaurantRegisterProvider extends ChangeNotifier{
  List<File> restaurantBannerImages = [];
  List<String> restaurantBannerImagesURL = []; 

  getRestaurantBannerImages(BuildContext context) async{
    restaurantBannerImages = await ImageServices.getImagesFromGallery(context: context);
    notifyListeners();
  }

  updateRestaurantBannerImagesURL(BuildContext context)async{
    restaurantBannerImages = await ImageServices.uploadImagesToFirebaseStorageNGetURL(images: restaurantBannerImages, context: context);
    notifyListeners();
  }
}