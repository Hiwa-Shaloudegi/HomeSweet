import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../my_custom_icon_icons.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndexItem = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: BottomNavigationBar(
        currentIndex: _selectedIndexItem,
        iconSize: 34,
        elevation: 12,
        selectedFontSize: 17,
        unselectedFontSize: 14,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.unselectedItemColor,
        onTap: (value) {
          setState(() {
            _selectedIndexItem = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(MyCustomIcon.profile),
            label: 'پروفایل',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyCustomIcon.home, size: 32),
            label: 'خانه',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyCustomIcon.building),
            label: 'آپارتمان',
          ),
        ],
      ),
    );
  }
}
