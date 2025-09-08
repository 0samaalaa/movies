import 'package:flutter/material.dart';
import '../../../../core/resources/app_Images.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/custom_text_filed.dart';


class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.black,
      appBar: AppBar(
        backgroundColor: MColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MColors.yellow),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: MColors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(MImages.avatar2),
            ),
            const SizedBox(height: 30),

            CustomTextFiled(
              hintText: "TEAM THREE",
              readOnly: true,
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
            const SizedBox(height: 30),
            CustomTextFiled(
              hintText: "+20 333333333",
              readOnly: true,
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
            const SizedBox(height: 15),

            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.forgetPasswordScreen);
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
            const SizedBox(height: 250),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MColors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.loginScreen);
                    },
                    child: const Text(
                      "Delete Account",
                      style: TextStyle(
                        color: MColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MColors.yellow,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.updateProfileScreen);
                    },
                    child: const Text(
                      "Update Data",
                      style: TextStyle(
                        color: MColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
