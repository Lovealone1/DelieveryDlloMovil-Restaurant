import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delievery_restaurants/utils/colors.dart';
import 'package:food_delievery_restaurants/view/addFoodItem/addFoodItem.dart';
import 'package:page_transition/page_transition.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: black,
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: const AddFoodItemScreen(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: white,
        ),
      ),
      body: Center(
        child: Text('Menu Screen'),
      ),
    );
  }
}
