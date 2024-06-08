import 'dart:developer';
import 'dart:io';

import 'package:covefood_domiciliario/controller/services/imageServices/imageServices.dart';
import 'package:covefood_domiciliario/controller/services/profileServices/profileServices.dart';
import 'package:covefood_domiciliario/model/driverModel/driverModel.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  DriverModel? driverProfile;
  File? profileImage;
  String? profileImageURL;

  pickImageFromGallery(BuildContext context) async {
    profileImage = await ImageServices.pickSingleImage(context: context);
    notifyListeners();
  }

  uploadImageAndGetImageURL(BuildContext context) async {
    List<String> url = await ImageServices.uploadImagesToFirebaseStorageNGetURL(
      images: [profileImage!],
      context: context,
    );
    if (url.isNotEmpty) {
      profileImageURL = url[0];
      log(profileImageURL!);
    }
    notifyListeners();
  }

  updateDriverProfile() async {
    driverProfile = await ProfileServices.getDelieveryPartnerProfileData();
    notifyListeners();
  }
}
