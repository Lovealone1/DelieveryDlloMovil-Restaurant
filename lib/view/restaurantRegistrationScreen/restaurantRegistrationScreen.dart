import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delievery_restaurants/utils/colors.dart';
import 'package:food_delievery_restaurants/utils/textStyles.dart';
import 'package:food_delievery_restaurants/widgets/textfieldWidget.dart';
import 'package:sizer/sizer.dart';

class AddFoodItemScreen extends StatefulWidget {
  const AddFoodItemScreen({super.key});

  @override
  State<AddFoodItemScreen> createState() => _AddFoodItemScreenState();
}

class _AddFoodItemScreenState extends State<AddFoodItemScreen> {
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController restaurantLicenceNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      children: [
        SizedBox(
          height: 2.h,
        ),
        Container(
          height: 20.h,
          width: 94.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            color: greyShade3,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
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
