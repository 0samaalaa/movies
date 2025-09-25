import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/app_icons.dart';
import '../../../../../main.dart';


class LanguageToggleSwitch extends StatelessWidget {
  const LanguageToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedToggleSwitch<String>.rolling(
        current: Localizations.localeOf(context).languageCode,
        values: const ["en", "ar"],
        height: 43,
        indicatorSize: const Size(43, 43),
        spacing: 20,
        onChanged: (newLang) {
          final newLocale = Locale(newLang);
          MoviesApp.of(context)?.setLocale(newLocale);
        },
        iconBuilder: (value, foreground) {
          final flag = value == "en" ? MIcons.en : MIcons.arabic;
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: foreground ? Border.all(color: MColors.yellow, width: 4) : null,
            ),
            child: ClipOval(child: Image.asset(flag, fit: BoxFit.cover)),
          );
        },
        style: ToggleStyle(
          backgroundColor: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          borderColor: MColors.yellow,
          indicatorColor: Colors.transparent,
          indicatorBorder: Border.all(color: MColors.yellow, width: 4),
        ),
      ),
    );
  }
}
