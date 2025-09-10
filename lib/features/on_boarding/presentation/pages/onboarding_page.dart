import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/on_boarding/presentation/onboarding_info.dart';
import 'package:movies/core/localization/app_localizations.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingInfo item;
  final bool isFirstPage;
  final bool isLastPage;
  final int pageIndex;
  final PageController pageController;

  const OnboardingPage({
    super.key,
    required this.item,
    required this.isFirstPage,
    required this.isLastPage,
    required this.pageIndex,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(item.image, fit: BoxFit.fill),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
            child: Container(
              width: double.infinity,
              color: MColors.black,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isFirstPage ? 36 : 24,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (item.description.trim().isNotEmpty)
                    Text(
                      item.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MColors.white.withOpacity(0.85),
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MColors.yellow,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () async {
                        if (isLastPage) {
                          context.read<OnboardingCubit>().completeOnboarding();
                          Navigator.pushReplacementNamed(
                              context, Routes.loginScreen);
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInCubic,
                          );
                        }
                      },
                      child: Text(
                        isFirstPage
                            ? l10n.exploreNow
                            : (isLastPage ? l10n.finish : l10n.next),
                        style: const TextStyle(
                          color: MColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (pageIndex > 1)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: MColors.yellow, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          l10n.back,
                          style: const TextStyle(
                            color: MColors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
