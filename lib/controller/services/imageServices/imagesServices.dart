import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_restaurants/controller/services/toastServices/toastMessageService.dart';
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
      // ignore: use_build_context_synchronously
      ToastService.sendScaffoldAlert(
          msg: 'No se seleccionaron imagenes',
          toastStatus: 'WARNING',
          context: context);
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

  static pickSingleImage({required BuildContext context}) async {
    File? selectedImage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    XFile? filePick = pickedFile;
    if (filePick != null) {
      selectedImage = File(filePick.path);
      return selectedImage;
    } else {
      // ignore: use_build_context_synchronously
      ToastService.sendScaffoldAlert(
          msg: 'No se seleccionó ninguna imagen',
          toastStatus: 'WARNING',
          context: context);
    }
  }

}
