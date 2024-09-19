import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/profileProvider/profileProvider.dart';
import '../../controller/services/fetchResturantsServices/fetchResturantsServices.dart';
import '../../utils/colors.dart';
import '../account/account.dart';
import '../basket/basketScreen.dart';
import '../browseScreen/browseScreen.dart';
import '../categoryScreen/categoryScreen.dart';
import '../home/homeScreen.dart';

class BottomNavigationBarUberEats extends StatefulWidget {
  const BottomNavigationBarUberEats({super.key});

  @override
  State<BottomNavigationBarUberEats> createState() =>
      _BottomNavigationBarUberEatsState();
}

class _BottomNavigationBarUberEatsState
    extends State<BottomNavigationBarUberEats> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProfileProvider>().fetchUserAddresses();
      context.read<ProfileProvider>().fetchUserData();
      ResturantServices.getNearbyResturants(context);
    });
  }

  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const CategoryScreen(),
      const GroceryScreen(),
      const BasketScreen(),
      const AccountScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const FaIcon(FontAwesomeIcons.house),
        title: "Trang chủ",
        activeColorPrimary: black,
        inactiveColorPrimary: grey,
      ),
      PersistentBottomNavBarItem(
        icon: const FaIcon(FontAwesomeIcons.boxesStacked),
        title: "Danh mục",
        activeColorPrimary: black,
        inactiveColorPrimary: grey,
      ),
      PersistentBottomNavBarItem(
        icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
        title: "Tìm kiếm",
        activeColorPrimary: black,
        inactiveColorPrimary: grey,
      ),
      PersistentBottomNavBarItem(
        icon: const FaIcon(FontAwesomeIcons.cartShopping),
        title: "Giỏ hàng",
        activeColorPrimary: black,
        inactiveColorPrimary: grey,
      ),
      PersistentBottomNavBarItem(
        icon: const FaIcon(FontAwesomeIcons.person),
        title: "Tài khoản",
        activeColorPrimary: black,
        inactiveColorPrimary: grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}