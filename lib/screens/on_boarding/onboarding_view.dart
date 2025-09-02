import 'package:flutter/material.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/screens/on_boarding/onboarding_item.dart';
import 'package:movies/screens/on_boarding/onboarding_page.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final Pagecontroller = PageController();

  @override
  void dispose() {
    Pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.black,
      body: PageView.builder(
        controller: Pagecontroller,
        itemCount: controller.items.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = controller.items[index];
          final isFirst = index == 0;
          final isLast = index == controller.items.length - 1;

          return OnboardingPage(
            item: item,
            isFirstPage: isFirst,
            isLastPage: isLast,
            pageIndex: index,
            pageController: Pagecontroller,
          );
        },
      ),
    );
  }
}
