import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delievery_restaurants/controller/services/imageServices/imagesServices.dart';

class AddFoodProvider extends ChangeNotifier{
  File? foodImage;
  String? foodImageURL; 

  pickFoodImageFromGallery(BuildContext context)async{
    foodImage = await ImageServices.pickSingleImage(context: context);
    notifyListeners();
  }

  uploadImageAndGetImageURL(BuildContext context) async{
    List<String> url =
        await ImageServices.uploadImagesToFirebaseStorageNGetURL(
            images: [foodImage!], context: context,);
    if(url.isNotEmpty){
      foodImageURL = url[0];
      log(foodImageURL!);
    }
    notifyListeners();
  }
}
