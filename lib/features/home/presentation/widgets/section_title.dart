import 'package:flutter/material.dart';
import '../../../../core/resources/app_Images.dart';

class SectionTitle extends StatelessWidget {
  final bool isAvailableNow;
  const SectionTitle({super.key, required this.isAvailableNow});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isAvailableNow ? 267 : 354,
      height: isAvailableNow ? 93 : 146,
      child: Image.asset(
        isAvailableNow ? MImages.an : MImages.wn,
        fit: BoxFit.contain,
      ),
    );
  }
}

