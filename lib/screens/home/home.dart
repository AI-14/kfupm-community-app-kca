import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_community_app/providers/home_screen_bottom_navbar.dart';
import 'package:kfupm_community_app/screens/buysell/buysell.dart';
import 'package:kfupm_community_app/screens/feeds/feeds.dart';
import 'package:kfupm_community_app/screens/messages/messages.dart';
import 'package:kfupm_community_app/screens/profile/profile.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenBottomNavbarProvider bottomNavbarProvider =
        Provider.of<HomeScreenBottomNavbarProvider>(context, listen: false);

    final List<Widget> items = [
      Icon(
        Icons.feed,
        color: darkThemeColor,
        size: 30,
      ),
      Icon(
        Icons.sell_rounded,
        color: darkThemeColor,
        size: 30,
      ),
      Icon(
        Icons.message_rounded,
        color: darkThemeColor,
        size: 30,
      ),
      Icon(
        Icons.account_circle_rounded,
        color: darkThemeColor,
        size: 30,
      ),
    ];

    final List<Widget> screens = [
      FeedsScreen(),
      BuySellScreen(),
      MessageScreen(),
      ProfileScreen()
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: darkThemeColor,
        body: Consumer<HomeScreenBottomNavbarProvider>(
          builder: (context, provider, child) {
            return screens[provider.index];
          },
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 55,
          items: items,
          color: primaryColor,
          backgroundColor: Colors.transparent,
          animationDuration: Duration(
            milliseconds: 300,
          ),
          onTap: (idx) => bottomNavbarProvider.setIndex(idx),
        ),
      ),
    );
  }
}
