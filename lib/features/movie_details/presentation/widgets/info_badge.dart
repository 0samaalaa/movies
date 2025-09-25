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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: MColors.dgrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: MColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
