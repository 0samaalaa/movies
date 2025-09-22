import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/resources/app_colors.dart';

class GenreTabBar extends StatelessWidget {
  final List<String> allGenres;
  final int selectedGenre;
  final ScrollController controller;
  final void Function(int index) onGenreSelected;

  GenreTabBar({
    super.key,
    required this.allGenres,
    required this.selectedGenre,
    required this.controller,
    required this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;

    final genreTranslations = {
      "all": l10n.all,
      "action": l10n.action,
      "adventure": l10n.adventure,
      "animation": l10n.animation,
      "biography": l10n.biography,
      "comedy": l10n.comedy,
      "crime": l10n.crime,
      "documentary": l10n.documentary,
      "drama": l10n.drama,
      "family": l10n.family,
      "fantasy": l10n.fantasy,
      "film-noir": l10n.filmNoir,
      "game-show": l10n.gameShow,
      "history": l10n.history,
      "horror": l10n.horror,
      "music": l10n.music,
      "musical": l10n.musical,
      "mystery": l10n.mystery,
      "news": l10n.news,
      "reality-tv": l10n.realityTV,
      "romance": l10n.romance,
      "sci-fi": l10n.sciFi,
      "sport": l10n.sport,
      "talk-show": l10n.talkShow,
      "thriller": l10n.thriller,
      "war": l10n.war,
      "western": l10n.western,
    };

    String translateGenre(String key) =>
        genreTranslations[key.toLowerCase()] ?? key;

    return SizedBox(
      height: 50,
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: allGenres.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == selectedGenre;
          final genreKey = allGenres[index].toLowerCase();

          return GestureDetector(
            onTap: () => onGenreSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? MColors.yellow : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: MColors.yellow, width: 1.5),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: 6,
              ),
              child: Text(
                translateGenre(genreKey),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.black : MColors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
