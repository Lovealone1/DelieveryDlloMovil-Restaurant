import 'package:flutter/material.dart';
import 'package:food_delievery_restaurants/utils/colors.dart';
import 'package:sizer/sizer.dart';

class CommonElevatedButton extends StatelessWidget {
  const CommonElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
  });
  final Widget child;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:onPressed ,
        style: ElevatedButton.styleFrom(
          backgroundColor: black,
          minimumSize: Size(90.w, 6.h),
        ),
        child: child);
  }
}
