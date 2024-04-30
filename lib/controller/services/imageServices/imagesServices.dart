import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:food_delievery_restaurants/constant/constant.dart';

class ImageServices {
  static getImagesFromGallery({required BuildContext context}) async {
    List<File> selectedImages = [];
    final pickedFile = await picker.pickMultiImage(imageQuality: 100);
    List<XFile> filePick = pickedFile;

    if (filePick.isNotEmpty) {
      for (var image in filePick) {
        selectedImages.add(File(image.path));
      }
    } else {
      //Show mensage
    }
    log('Las imagenes estan \n ${selectedImages.toList().toString()}');
    return selectedImages;
  }

  static uploadImagesToFirebaseStorageNGetURL(
      {required List<File> images, required BuildContext context}) async {
    List<String> imagesURL = [];
    String sellerUID = auth.currentUser!.uid;
    await Future.forEach(images, (image) async {
      String imageName = '$sellerUID${uuid.v1().toString()}';
      Reference ref =
          storage.ref().child('RestaurantBannerImages').child(imageName);
      await ref.putFile(File(image.path));
      String imageURL = await ref.getDownloadURL();
      imagesURL.add(imageURL);
    });
    return imagesURL; 
  }
}
