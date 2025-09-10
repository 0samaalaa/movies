import 'package:flutter/material.dart';
import '../../../../core/resources/app_Images.dart';
import '../../../../core/resources/app_colors.dart';
import '../widgets/searchbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchBarWidget(),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Image.asset(
                  MImages.popcorn,
                  width: 120,
                  height: 120,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
