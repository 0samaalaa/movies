import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:movies/core/app_Images.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_icons.dart';
import 'package:movies/core/app_routes.dart';
import 'package:movies/core/custom_text_filed.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _lang = "en";

  @override
  Widget build(BuildContext context) {
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
                hintText: "Email",
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
                hintText: "Password",
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
                    Navigator.pushNamed(context, APPROUTES.forgetPasswordScreen);
                  },
                  child: const Text(
                    "Forget Password ?",
                    style: TextStyle(
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
                    Navigator.pushNamed(context, APPROUTES.layoutScreen);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
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
                  const Text(
                    "Don’t Have Account ?",
                    style: TextStyle(color: MColors.white, fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                     Navigator.pushNamed(context, APPROUTES.registerScreen);
                    },
                    child: const Text(
                      "Create One",
                      style: TextStyle(
                        color: MColors.yellow,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 90,
                    child: Divider(color: MColors.yellow, thickness: 0.8),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "  OR  ",
                      style: TextStyle(color: MColors.yellow, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Divider(color: MColors.yellow, thickness: 0.8),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                   Navigator.pushNamed(context, APPROUTES.layoutScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(MIcons.google, height: 22, width: 22),
                      const SizedBox(width: 12),
                      const Text(
                        "Login With Google",
                        style: TextStyle(
                          color: MColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: AnimatedToggleSwitch<String>.rolling(
                  current: _lang,
                  values: const ["en", "ar"],
                  height: 43,
                  indicatorSize: const Size(43, 43),
                  spacing: 20,
                  onChanged: (i) => setState(() => _lang = i),
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
                        child: Image.asset(
                          flag,
                          fit: BoxFit.cover,
                        ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
