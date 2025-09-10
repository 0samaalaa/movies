import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/app_icons.dart';
import '../../../../../core/widgets/custom_text_filed.dart';
import '../../../../core/resources/app_Images.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../profile/presentation/bloc/profile_event.dart';
import '../../../profile/presentation/bloc/profile_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context,
      {required String title,
        required String message,
        required ContentType type}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
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
      backgroundColor: MColors.black,
      appBar: AppBar(
        title: Text(
          l10n.resetPassword,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: MColors.yellow,
          ),
        ),
        backgroundColor: MColors.black,
        iconTheme: const IconThemeData(color: MColors.yellow),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is PasswordResetSuccess) {
            _showSnackBar(
              context,
              title: "success",
              message: state.message,
              type: ContentType.success,
            );
            Navigator.pop(context);
          } else if (state is PasswordResetFailure) {
            _showSnackBar(
              context,
              title: "error",
              message: state.error,
              type: ContentType.failure,
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator(color: MColors.yellow));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Image.asset(
                  MImages.forgot,
                ),
              ),
              const SizedBox(height: 40),

              // Old Password
              CustomTextFiled(
                controller: oldPasswordController,
                hintText: l10n.oldPassword,
                obscureText: !_isOldPasswordVisible,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    MIcons.lock,
                    width: 20,
                    height: 20,
                    color: MColors.white,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isOldPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: MColors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isOldPasswordVisible = !_isOldPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // New Password
              CustomTextFiled(
                controller: newPasswordController,
                hintText: l10n.newPassword,
                obscureText: !_isNewPasswordVisible,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    MIcons.lock,
                    width: 20,
                    height: 20,
                    color: MColors.white,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isNewPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: MColors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 40),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MColors.yellow,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    final oldPassword = oldPasswordController.text.trim();
                    final newPassword = newPasswordController.text.trim();

                    if (oldPassword.isNotEmpty && newPassword.isNotEmpty) {
                      context.read<ProfileBloc>().add(
                        ResetPasswordEvent(
                          oldPassword: oldPassword,
                          newPassword: newPassword,
                        ),
                      );
                    }
                  },
                  child: Text(
                    l10n.resetPassword,
                    style: const TextStyle(
                      color: MColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
