import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/resources/app_Images.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_icons.dart';
import '../../../core/routes/routes.dart';
import '../../../core/widgets/custom_text_filed.dart';
import '../../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _lang = "en";

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZoomIn(
                duration: const Duration(seconds: 2),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 20,
                  ),
                  child: Image.asset(
                    MImages.logo2,
                    width: 110,
                    height: 110,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomTextFiled(
                hintText: l10n.email,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    MIcons.mail,
                    width: 18,
                    height: 18,
                    color: MColors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomTextFiled(
                hintText: l10n.password,
                isPassword: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    MIcons.lock,
                    width: 18,
                    height: 18,
                    color: MColors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.forgetPasswordScreen);
                  },
                  child: Text(
                    l10n.forgetPassword,
                    style: const TextStyle(
                      fontSize: 14,
                      color: MColors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MColors.yellow,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.layoutScreen);
                  },
                  child: Text(
                    l10n.login,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: MColors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.dontHaveAccount,
                    style: const TextStyle(color: MColors.white, fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.registerScreen);
                    },
                    child: Text(
                      l10n.createOne,
                      style: const TextStyle(
                        color: MColors.yellow,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Directionality(
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
                        border: foreground
                            ? Border.all(color: MColors.yellow, width: 4)
                            : null,
                      ),
                      child: ClipOval(
                        child: Image.asset(flag, fit: BoxFit.cover),
                      ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
