import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_app/view/monthly.dart';
import 'package:flutter_todo_app/view/weekly.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'daily.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int currentIndex = 0;

  PersistentTabController? _controller;

  TextStyle textStyle =
      const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700);

  List<Widget> _buildScreens() {
    return [
      const Weekly(),
      const Daily(),
      const Monthly(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.calendar_today, size: 20, color: Colors.white),
            Text('Haftalık', style: textStyle)
          ],
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.white),
            Text('Günlük', style: textStyle)
          ],
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.calendar_view_month, size: 20, color: Colors.white),
            Text('Aylık', style: textStyle)
          ],
        ),
      ),
    ];
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: 0);
    return Material(
      child: PersistentTabView(
        context,
        controller: _controller,
        padding: const NavBarPadding.symmetric(horizontal: 2),
        screens: _buildScreens(),
        items: _navBarsItems(context),
        onItemSelected: changeIndex,
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0.0),
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue.shade900],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }
}
