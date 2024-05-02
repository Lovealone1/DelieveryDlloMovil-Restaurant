import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_restaurants/controller/provider/addFoodProvider/addFoodProvider.dart';
import 'package:food_delievery_restaurants/controller/provider/authProvider/MobileAuthProvider.dart';
import 'package:food_delievery_restaurants/controller/provider/restaurantRegisterProvider/restaurantRegisterProvider.dart';
import 'package:food_delievery_restaurants/firebase_options.dart';
import 'package:food_delievery_restaurants/view/signInLogicScreen/signInLoginScreen.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FoodDelievery());
}

class FoodDelievery extends StatelessWidget {
  const FoodDelievery({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<MobileAuthProvider>(
            create: (_) => MobileAuthProvider(),
          ),
          ChangeNotifierProvider<RestaurantRegisterProvider>(
            create: (_) => RestaurantRegisterProvider(),
          ),
          ChangeNotifierProvider<AddFoodProvider>(
            create: (_) => AddFoodProvider(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(),
            home: const SignInLogicScreen()),
      );
    });
  }
}
