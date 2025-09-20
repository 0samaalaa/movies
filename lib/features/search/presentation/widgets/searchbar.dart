import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/localization/app_localizations.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  const SearchBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return TextFormField(
          controller: controller,
          onChanged: (val) {
            context.read<SearchBloc>().add(
              SearchMovieEvent(val.trim().toLowerCase()),
            );
          },
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
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear, color: MColors.white),
              onPressed: () {
                controller.clear();
                context.read<SearchBloc>().add(SearchMovieEvent(""));
              },
            )
                : null,
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
      },
    );
  }
}
