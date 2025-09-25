import 'package:flutter/material.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/utils/avatar_helper.dart';

class AvatarPicker extends StatelessWidget {
  final int selectedAvatarId;
  final Function(int) onAvatarSelected;

  const AvatarPicker({
    super.key,
    required this.selectedAvatarId,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    final avatars = AvatarHelper.allAvatars;
    return GestureDetector(
      onTap: () {
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
                    final isSelected = (index + 1) == selectedAvatarId;
                    return GestureDetector(
                      onTap: () {
                        onAvatarSelected(index + 1);
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
      },
      child: CircleAvatar(
        radius: 60,
        backgroundImage: AssetImage(AvatarHelper.getAvatarAsset(selectedAvatarId)),
      ),
    );
  }
}