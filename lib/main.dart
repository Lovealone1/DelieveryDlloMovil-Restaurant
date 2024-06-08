import 'package:covefood_domiciliario/controller/provider/authProvider/MobileAuthProvider.dart';
import 'package:covefood_domiciliario/controller/provider/profileProvider/profileProvider.dart';
import 'package:covefood_domiciliario/controller/provider/rideProvider/rideProvider.dart';
import 'package:covefood_domiciliario/firebase_options.dart';
import 'package:covefood_domiciliario/view/signInLogicScreen/signInLoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
          ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider(),
          ),
          ChangeNotifierProvider<RideProvider>(
            create: (_) => RideProvider(),
          ),
          
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(),
          home: const SignInLogicScreen(),
          //home: DriverRegistrationScreen(),
        ),
      );
    });
  }
}
