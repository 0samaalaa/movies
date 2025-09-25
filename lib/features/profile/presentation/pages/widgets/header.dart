import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/app_icons.dart';
import '../../../../../core/utils/avatar_helper.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final int avatarId;
  final int watchlistCount;
  final int historyCount;
  final VoidCallback onEditProfile;
  final VoidCallback onLogout;

  const ProfileHeader({
    required this.userName,
    required this.avatarId,
    required this.watchlistCount,
    required this.historyCount,
    required this.onEditProfile,
    required this.onLogout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    AvatarHelper.getAvatarAsset(avatarId),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  userName,
                  style: const TextStyle(
                    color: MColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCountColumn(watchlistCount, l10n.watchList),
                    const SizedBox(width: 24),
                    _buildCountColumn(historyCount, l10n.history),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: onEditProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MColors.yellow,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  l10n.editProfile,
                  style: const TextStyle(
                      color: MColors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: onLogout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MColors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.exit,
                      style: const TextStyle(
                        color: MColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Image.asset(
                      MIcons.logout,
                      height: 20,
                      width: 20,
                      color: MColors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildCountColumn(int count, String label) {
    return Column(
      children: [
        Text(
          "$count",
          style: const TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: MColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
