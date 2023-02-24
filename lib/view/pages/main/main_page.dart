import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';
import 'package:spatu/view/pages/main/home_page.dart';
import 'package:spatu/view/pages/main/notification_page.dart';
import 'package:spatu/view/pages/main/profile_page.dart';
import 'package:spatu/view/pages/main/wishlist_page.dart';

import 'exploration_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildBody(),
    );
  }

  void _changeToExplorationPage() {
    setState(() {
      currentIndex = 1;
    });
  }

  Widget _buildBody() {
    switch (currentIndex) {
      case 0:
        return HomePage(onSearchTapped: _changeToExplorationPage);
      case 1:
        return const ExplorationPage();
      case 2:
        return WishlistPage(onSearchTapped: _changeToExplorationPage);
      case 3:
        return const NotificationPage();
      case 4:
        return const ProfilePage();
      default:
        return HomePage(onSearchTapped: _changeToExplorationPage);
    }
  }

  Widget _buildBottomNavigationBar() {
    return SizedBox(
      height: 90.h,
      child: BottomNavigationBar(
        backgroundColor: blackColor,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Image.asset(
              currentIndex == 0
                  ? 'assets/icons/home_selected.png'
                  : 'assets/icons/home.png',
              width: 24.w,
              height: 24.h,
              color: currentIndex == 0 ? primaryColor : grayColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Image.asset(
              currentIndex == 1
                  ? 'assets/icons/exploration_selected.png'
                  : 'assets/icons/exploration.png',
              width: 24.w,
              height: 24.h,
              color: currentIndex == 1 ? null : grayColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Image.asset(
              currentIndex == 2
                  ? 'assets/icons/favorite_selected.png'
                  : 'assets/icons/wishlist.png',
              width: 24.w,
              height: 24.h,
              color: currentIndex == 2 ? primaryColor : grayColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Image.asset(
              currentIndex == 3
                  ? 'assets/icons/notification_selected.png'
                  : 'assets/icons/notification.png',
              width: 24.w,
              height: 24.h,
              color: currentIndex == 3 ? primaryColor : grayColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Image.asset(
              currentIndex == 4
                  ? 'assets/icons/profile_selected.png'
                  : 'assets/icons/profile.png',
              width: 24.w,
              height: 24.h,
              color: currentIndex == 4 ? primaryColor : grayColor,
            ),
          ),
        ],
      ),
    );
  }
}
