import 'package:flutter/material.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/app_icons.dart';
import '../../../../../core/widgets/custom_text_filed.dart';


class ProfileFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final VoidCallback onResetPassword;

  const ProfileFormFields({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.onResetPassword,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        CustomTextFiled(
          controller: nameController,
          hintText: l10n.name,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(MIcons.name, width: 20, height: 20, color: MColors.white),
          ),
        ),
        const SizedBox(height: 30),
        CustomTextFiled(
          controller: phoneController,
          hintText: l10n.phoneNumber,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(MIcons.call, width: 20, height: 20, color: MColors.white),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: onResetPassword,
            child:  Text(l10n.resetPassword,
              style: TextStyle(
                color: MColors.yellow,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
