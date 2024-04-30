import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delievery_restaurants/utils/colors.dart';
import 'package:food_delievery_restaurants/view/account/account.dart';
import 'package:food_delievery_restaurants/view/addFoodItem/addFoodItem.dart';
//import 'package:food_delievery_restaurants/view/home/homeScreen.dart';
import 'package:food_delievery_restaurants/view/menuScreen/menuScreen.dart';
import 'package:food_delievery_restaurants/view/statusScreen/statusScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavigationBarDelievery extends StatefulWidget {
  const BottomNavigationBarDelievery({super.key});

  @override
  State<BottomNavigationBarDelievery> createState() => _BottomNavigationBarDelieveryState();
}

class _BottomNavigationBarDelieveryState extends State<BottomNavigationBarDelievery> {

  PersistentTabController controller =  PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens(){
    return [
      //const HomeScreen(),
      const AddFoodItemScreen(),
      const MenuScreen(),
      const StatusScreen(),
      const AccountScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: FaIcon(FontAwesomeIcons.house),
                title: ("Principal"),
                activeColorPrimary: black,
                inactiveColorPrimary:grey,
            ),
            PersistentBottomNavBarItem(
                icon: FaIcon(FontAwesomeIcons.list),
                title: ("Menu"),
                activeColorPrimary: black,
                inactiveColorPrimary:grey,
            ),
            PersistentBottomNavBarItem(
                icon: FaIcon(FontAwesomeIcons.chartSimple),
                title: ("Status"),
                activeColorPrimary: black,
                inactiveColorPrimary:grey,
            ),
            PersistentBottomNavBarItem(
                icon:FaIcon(FontAwesomeIcons.person),
                title: ("Cuenta"),
                activeColorPrimary: black,
                inactiveColorPrimary:grey,
            ),
        ];
    }

  @override
  Widget build(BuildContext context) {
    return  PersistentTabView(
        context,
        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}

