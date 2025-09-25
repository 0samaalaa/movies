import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/profile/presentation/pages/widgets/LanguageToggleSwitch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../auth/presentation/pages/reset_password.dart';
import '../../../on_boarding/presentation/pages/onboarding_view.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'widgets/avatar_picker.dart';
import 'widgets/profile_form_fields.dart';
import 'widgets/profile_action_buttons.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  int selectedAvatarId = 1;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    _loadProfileFromPrefs();
    context.read<ProfileBloc>().add(LoadProfileEvent());
  }

  Future<void> _loadProfileFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString("userName") ?? "";
      phoneController.text = prefs.getString("phone") ?? "";
      selectedAvatarId = prefs.getInt("avatarId") ?? 1;
    });
  }

  void _saveToPrefs(String name, int avatarId, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", name);
    await prefs.setInt("avatarId", avatarId);
    await prefs.setString("phone", phone);
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
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          _saveToPrefs(nameController.text.trim(), selectedAvatarId, phoneController.text.trim());
          Navigator.pop(context, {
            "name": nameController.text.trim(),
            "avaterId": selectedAvatarId,
            "phone": phoneController.text.trim(),
          });
        } else if (state is ProfileDeleted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const OnboardingView()),
                (route) => false,);
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
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
              style: const TextStyle(color: MColors.yellow, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AvatarPicker(
                          selectedAvatarId: selectedAvatarId,
                          onAvatarSelected: (id) => setState(() => selectedAvatarId = id),
                        ),
                        const SizedBox(height: 30),
                        ProfileFormFields(
                          nameController: nameController,
                          phoneController: phoneController,
                          onResetPassword: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
                          ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const LanguageToggleSwitch(),
                const SizedBox(height: 50),
                ProfileActionButtons(
                  onUpdate: () {
                    final name = nameController.text.trim();
                    final phone = phoneController.text.trim();
                    context.read<ProfileBloc>().add(UpdateProfileEvent(
                      name: name,
                      phone: phone,
                      avatarId: selectedAvatarId,
                    ));
                  },
                  onDelete: () => context.read<ProfileBloc>().add(DeleteAccountEvent()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
