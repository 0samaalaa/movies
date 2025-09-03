import 'package:flutter/material.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_icons.dart';
import 'package:movies/screens/browse_screen/browse_screen.dart';
import 'package:movies/screens/profile_screen/profile_screen.dart';
import 'package:movies/screens/search_screen/search_screen.dart';
import '../screens/home screen/home_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(15),
        height: 70,
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: MColors.dgrey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(icon: MIcons.home, index: 0),
                  _buildNavItem(icon: MIcons.search, index: 1),
                  _buildNavItem(icon: MIcons.explore, index: 2),
                  _buildNavItem(icon: MIcons.profile, index: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required String icon, required int index}) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: 40,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: ImageIcon(
            AssetImage(icon),
            size: 26,
            color: isSelected ? MColors.yellow : Colors.white,
          ),
        ),
      ),
    );
  }
}


