import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodDescriptionController = TextEditingController();
  TextEditingController foodPriceController = TextEditingController();
  bool foodIsPureVegetarian = true;

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
          controller: foodNameController,
          title: 'Nombre ',
          hintText: 'Nombre de la comida ',
          keyboardType: TextInputType.name,
        ),
        SizedBox(
          height: 2.h,
        ),
        CommonTextfield(
          controller: foodDescriptionController,
          title: 'Descripcion ',
          hintText: 'Descripcion de la comida',
          keyboardType: TextInputType.name,
        ),
        SizedBox(
          height: 2.h,
        ),
        CommonTextfield(
          controller: foodPriceController,
          title: 'Precio ',
          hintText: 'Precio de la comida',
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          '¿El plato es vegetrariano?',
          style: AppTextStyles.body16Bold,
        ),
        SizedBox(
          height: 0.8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  foodIsPureVegetarian = true;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 3.h,
                    width: 3.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: foodIsPureVegetarian
                          ? Colors.green.shade100
                          : transparent,
                      borderRadius: BorderRadius.circular(3.sp),
                      border: Border.all(
                        color: foodIsPureVegetarian ? black : grey,
                      ),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.check,
                      size: 2.h,
                      color: foodIsPureVegetarian ? black : transparent,
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    'Vegetariano',
                    style: AppTextStyles.body14,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  foodIsPureVegetarian = false;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 3.h,
                    width: 3.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: !foodIsPureVegetarian
                          ? Colors.red.shade100
                          : transparent,
                      borderRadius: BorderRadius.circular(3.sp),
                      border: Border.all(
                        color: !foodIsPureVegetarian ? black : grey,
                      ),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.check,
                      size: 2.h,
                      color: !foodIsPureVegetarian ? black : transparent,
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    'No vegetariano',
                    style: AppTextStyles.body14,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}

