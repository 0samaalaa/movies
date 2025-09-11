import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/avatar_picker.dart';
import '../../../../core/widgets/custom_text_filed.dart';
import '../../../../main.dart';
import '../../data/repositories/auth_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  int _selectedAvatarId = 1;
  String _lang = "en";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lang = Localizations.localeOf(context).languageCode;
  }

  void showAwesomeSnackBar(BuildContext context, String title, String message, ContentType type) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MColors.yellow),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.register,
          style: const TextStyle(
            color: MColors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            AvatarPicker(
              onAvatarSelected: (id) {
                _selectedAvatarId = id;
              },
            ),
            const SizedBox(height: 5),
            Text(
              l10n.avatar,
              style: const TextStyle(color: MColors.white, fontSize: 16),
            ),
            const SizedBox(height: 25),
            CustomTextFiled(
              controller: nameController,
              hintText: l10n.name,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  MIcons.name,
                  width: 20,
                  height: 20,
                  color: MColors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextFiled(
              controller: emailController,
              hintText: l10n.email,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  MIcons.mail,
                  width: 20,
                  height: 20,
                  color: MColors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextFiled(
              controller: passwordController,
              hintText: l10n.password,
              isPassword: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  MIcons.lock,
                  width: 20,
                  height: 20,
                  color: MColors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextFiled(
              controller: confirmPasswordController,
              hintText: l10n.confirmPassword,
              isPassword: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  MIcons.lock,
                  width: 20,
                  height: 20,
                  color: MColors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextFiled(
              controller: phoneController,
              hintText: l10n.phoneNumber,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  MIcons.call,
                  width: 20,
                  height: 20,
                  color: MColors.white,
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MColors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () async {
                  if (passwordController.text != confirmPasswordController.text) {
                    showAwesomeSnackBar(context, "Error", "Passwords do not match", ContentType.failure);
                    return;
                  }
                  try {
                    final message = await AuthRepository().registerUser(
                      name: nameController.text,
                      email: emailController.text.trim().toLowerCase(),
                      password: passwordController.text,
                      confirmPassword: confirmPasswordController.text,
                      phone: phoneController.text,
                      avatarId: _selectedAvatarId,
                    );
                    showAwesomeSnackBar(context, "Success", message, ContentType.success);
                    Navigator.pushNamed(context, Routes.loginScreen);
                  } catch (e) {
                    showAwesomeSnackBar(context, "Error", e.toString(), ContentType.failure);
                  }
                },
                child: Text(
                  l10n.createAccount,
                  style: const TextStyle(
                    color: MColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.alreadyHaveAccount,
                  style: const TextStyle(color: MColors.white),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.loginScreen);
                  },
                  child: Text(
                    l10n.login,
                    style: const TextStyle(
                      color: MColors.yellow,
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
    );
  }
}
