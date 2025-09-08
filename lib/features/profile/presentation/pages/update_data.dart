import 'package:flutter/material.dart';

import '../../../../core/resources/app_Images.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/widgets/custom_text_filed.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String selectedAvatar = MImages.avatar2;

  final TextEditingController nameController =
  TextEditingController(text: "TEAM THREE");
  final TextEditingController phoneController =
  TextEditingController(text: "+20 333333333");

  final List<String> avatars = [
    MImages.avatar1,
    MImages.avatar2,
    MImages.avatar3,
    MImages.avatar4,
    MImages.avatar5,
    MImages.avatar6,
    MImages.avatar7,
    MImages.avatar8,
    MImages.avatar9,
  ];

  void _openAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: MColors.dgrey,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: avatars.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final avatar = avatars[index];
                final isSelected = avatar == selectedAvatar;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatar = avatar;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? MColors.yellow.withOpacity(0.56) : Colors.transparent,
                      border: Border.all(color: MColors.yellow, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Align(
                      alignment: Alignment.center,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        heightFactor: 0.9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            avatar,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

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
          "Update Profile",
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
            GestureDetector(
              onTap: _openAvatarPicker,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(selectedAvatar),
              ),
            ),
            const SizedBox(height: 30),
            CustomTextFiled(
              controller: nameController,
              hintText: "TEAM THREE",
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
              controller: phoneController,
              hintText: "+20 333333333",
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
            const SizedBox(height: 40),
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
                  Navigator.pop(context);
                },
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
