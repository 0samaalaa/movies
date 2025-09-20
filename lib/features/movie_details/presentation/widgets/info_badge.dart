import 'package:flutter/material.dart';
import '../../../../core/resources/app_colors.dart';

class InfoBadge extends StatelessWidget {
  final String iconPath;
  final String label;

  const InfoBadge({
    super.key,
    required this.iconPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: MColors.dgrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 25,
            height: 25,
          ),
          const SizedBox(width: 15),
          Text(
            label,
            style: const TextStyle(
              color: MColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
