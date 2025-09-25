import 'package:flutter/cupertino.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/app_icons.dart';

class ProfileTabs extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabSelected;

  const ProfileTabs({required this.selectedTab, required this.onTabSelected, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(child: _buildTabItem(0, MIcons.items, l10n.watchList)),
        Expanded(child: _buildTabItem(1, MIcons.folder, l10n.history)),
      ],
    );
  }

  Widget _buildTabItem(int index, String assetPath, String label) {
    bool isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Column(
        children: [
          Image.asset(assetPath,
              height: 28, width: 28, color: isSelected ? MColors.yellow : MColors.white),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  color: isSelected ? MColors.yellow : MColors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 3,
              width: double.infinity,
              color: MColors.yellow,
            ),
        ],
      ),
    );
  }
}
