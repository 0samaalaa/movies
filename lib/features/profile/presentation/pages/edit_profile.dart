import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/avatar_helper.dart';
import '../../../../core/widgets/custom_text_filed.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;

  int selectedAvatarId = 1; // default avatarId
  late String selectedAvatar;

  final List<String> avatars = AvatarHelper.allAvatars;

  String getAvatarAsset(int? id) {
    if (id != null && id > 0 && id <= avatars.length) {
      return avatars[id - 1];
    }
    return avatars[0];
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    selectedAvatar = getAvatarAsset(selectedAvatarId); // init with default
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<ProfileBloc>().state;
    if (state is ProfileLoaded) {
      final data = state.profileData;
      nameController.text = data["name"] ?? "";
      phoneController.text = data["phone"] ?? "";
      selectedAvatarId = data["avaterId"] ?? 1;
      selectedAvatar = getAvatarAsset(selectedAvatarId);
    }
  }


  void showAwesomeSnackBar(String title, String message, ContentType type) {
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

  void openAvatarPicker() {
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
              itemCount: avatars.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (_, index) {
                final avatar = avatars[index];
                final isSelected = avatar == selectedAvatar;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatar = avatar;
                      selectedAvatarId = index + 1;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? MColors.yellow.withOpacity(0.56)
                          : Colors.transparent,
                      border: Border.all(color: MColors.yellow, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(avatar, fit: BoxFit.cover),
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
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MColors.black,
      appBar: AppBar(
        backgroundColor: MColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MColors.yellow),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.editProfile,
          style: const TextStyle(
            color: MColors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            showAwesomeSnackBar("Success", state.message, ContentType.success);
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
          } else if (state is ProfileError) {
            showAwesomeSnackBar("Error", state.message, ContentType.failure);
          } else if (state is ProfileDeleted) {
            showAwesomeSnackBar("Success", state.message, ContentType.success);
            Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginScreen,
            (route) => false);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: openAvatarPicker,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(selectedAvatar),
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextFiled(
                          controller: nameController,
                          hintText: l10n.name,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(MIcons.name,
                                width: 20, height: 20, color: MColors.white),
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextFiled(
                          controller: phoneController,
                          hintText: 'phone',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(MIcons.call,
                                width: 20, height: 20, color: MColors.white),
                          ),
                        ),
                        const SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.resetPasswordScreen);
                              },
                            child: Text(
                              l10n.resetPassword,
                              style: const TextStyle(
                                color: MColors.yellow,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ProfileBloc>().add(DeleteAccountEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MColors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          l10n.deleteAccount,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ProfileBloc>().add(
                            UpdateProfileEvent(
                              name: nameController.text.trim(),
                              phone: phoneController.text.trim(),
                              avatarId: selectedAvatarId,
                            ),
                          );

                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: MColors.yellow,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          l10n.updateData,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
