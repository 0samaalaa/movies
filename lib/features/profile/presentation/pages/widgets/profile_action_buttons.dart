import 'package:flutter/material.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/resources/app_colors.dart';

class ProfileActionButtons extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const ProfileActionButtons({
    super.key,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onDelete,
            style: ElevatedButton.styleFrom(
              backgroundColor: MColors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              l10n.deleteAccount,
              style: const TextStyle(fontWeight: FontWeight.bold, color: MColors.white),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onUpdate,
            style: ElevatedButton.styleFrom(
              backgroundColor: MColors.yellow,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              l10n.updateData,
              style: const TextStyle(fontWeight: FontWeight.bold, color: MColors.black),
            ),
          ),
        ),
      ],
    );
  }
}
