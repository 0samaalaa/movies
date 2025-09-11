import 'package:movies/features/on_boarding/presentation/onboarding_info.dart';
import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';

class OnboardingItems {
  static List<OnboardingInfo> getItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return [
      OnboardingInfo(
        image: "assets/images/ON1.png",
        title: l10n.onboardingTitle1,
        description: l10n.onboardingDesc1,
      ),
      OnboardingInfo(
        image: "assets/images/ON2.png",
        title: l10n.onboardingTitle2,
        description: l10n.onboardingDesc2,
      ),
      OnboardingInfo(
        image: "assets/images/ON3.png",
        title: l10n.onboardingTitle3,
        description: l10n.onboardingDesc3,
      ),
      OnboardingInfo(
        image: "assets/images/ON4.png",
        title: l10n.onboardingTitle4,
        description: l10n.onboardingDesc4,
      ),
      OnboardingInfo(
        image: "assets/images/ON5.png",
        title: l10n.onboardingTitle5,
        description: l10n.onboardingDesc5,
      ),
      OnboardingInfo(
        image: "assets/images/ON6.png",
        title: l10n.onboardingTitle6,
        description: l10n.onboardingDesc6,
      ),
    ];
  }
}
