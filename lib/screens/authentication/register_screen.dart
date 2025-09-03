import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_icons.dart';
import 'package:movies/core/app_routes.dart';
import 'package:movies/core/custom_text_filed.dart';
import '../../core/avatar_picker.dart';

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
  String _lang = "en";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MColors.yellow),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Register",
          style: TextStyle(
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
            const AvatarPicker(),
            const SizedBox(height: 5),
            const Text(
              "Avatar",
              style: TextStyle(color: MColors.white, fontSize: 16),
            ),
            const SizedBox(height: 25),
            CustomTextFiled(
              hintText: "Name",
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
              hintText: "Email",
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
              hintText: "Password",
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
              hintText: "Confirm Password",
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
              hintText: "Phone Number",
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
                onPressed: () {},
                child: const Text(
                  "Create Account",
                  style: TextStyle(
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
                const Text(
                  "Already Have Account ? ",
                  style: TextStyle(color: MColors.white),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, APPROUTES.loginScreen);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: MColors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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
    );
  }
}
