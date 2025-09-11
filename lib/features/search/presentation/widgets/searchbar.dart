import 'package:flutter/material.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/localization/app_localizations.dart';


class SearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;

  const SearchBarWidget({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        color: MColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: MColors.dgrey,
        hintText: l10n.search,
        hintStyle: const TextStyle(
          color: MColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Image.asset(
            MIcons.search,
            width: 24,
            height: 24,
            color: MColors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: MColors.yellow, width: 2),
        ),
      ),
    );
  }
}
