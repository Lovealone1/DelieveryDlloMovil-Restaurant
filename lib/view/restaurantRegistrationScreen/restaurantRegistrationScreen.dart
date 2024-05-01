import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delievery_restaurants/controller/provider/restaurantRegisterProvider/restaurantRegisterProvider.dart';
import 'package:food_delievery_restaurants/utils/colors.dart';
import 'package:food_delievery_restaurants/utils/textStyles.dart';
import 'package:food_delievery_restaurants/widgets/textfieldWidget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RestaurantRegistrationScreen extends StatefulWidget {
  const RestaurantRegistrationScreen({super.key});

  @override
  State<RestaurantRegistrationScreen> createState() =>
      _RestaurantRegistrationScreen();
}

class _RestaurantRegistrationScreen
    extends State<RestaurantRegistrationScreen> {
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController restaurantLicenceNumberController =
      TextEditingController();
  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      children: [
        SizedBox(
          height: 2.h,
        ),
        Consumer<RestaurantRegisterProvider>(
            builder: (context, registrationProvider, child) {
          if (registrationProvider.restaurantBannerImages.isEmpty) {
            return InkWell(
              onTap: () async {
                await registrationProvider.getRestaurantBannerImages(context);
              },
              child: Container(
                height: 20.h,
                width: 94.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp),
                  color: greyShade3,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5.h,
                      width: 5.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: black,
                        ),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        size: 3.h,
                        color: black,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Agregar',
                      style: AppTextStyles.body14,
                    )
                  ],
                ),
              ),
            );
          } else {
            List<File> bannerImages =
                registrationProvider.restaurantBannerImages;
            return Container(
              height: 23.h,
              width: 94.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp),
                  border: Border.all(color: greyShade3)),
              child: CarouselSlider(
                carouselController: controller,
                options: CarouselOptions(
                  height: 23.h,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
                items: bannerImages
                    .map(
                      (image) => Container(
                        width: 94.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }
        }),
        SizedBox(
          height: 4.h,
        ),
        CommonTextfield(
          controller: restaurantNameController,
          title: 'Nombre ',
          hintText: 'Nombre del restaurante ',
          keyboardType: TextInputType.name,
        ),
        SizedBox(
          height: 2.h,
        ),
        CommonTextfield(
          controller: restaurantLicenceNumberController,
          title: 'Licencia de registro ',
          hintText: 'Numero de licencia',
          keyboardType: TextInputType.name,
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    ));
  }
}
