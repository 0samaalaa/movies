import 'package:flutter/material.dart';
import '../../../../core/resources/app_colors.dart';
import '../widgets/onboarding_item.dart';
import 'onboarding_page.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({
    super.key,
  });

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.black,
      body: PageView.builder(
        controller: pageController,
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
            pageController: pageController,
          );
        },
      ),
    );
  }
}
