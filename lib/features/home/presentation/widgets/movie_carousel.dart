import 'package:flutter/material.dart';
import 'package:movies/features/home/presentation/widgets/section_title.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../domain/entities/movie.dart';
import 'movie_card.dart';

class MovieCarousel extends StatefulWidget {
  final List<Movie> movies;
  const MovieCarousel({super.key, required this.movies});

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: 0.59);
  }

  String _getTranslatedGenre(BuildContext context, String genre) {
    switch (genre.toLowerCase()) {
      case "action":
        return AppLocalizations.of(context)!.action;
      case "drama":
        return AppLocalizations.of(context)!.drama;
      case "fantasy":
        return AppLocalizations.of(context)!.fantasy;
      case "sci-fi":
        return AppLocalizations.of(context)!.sciFi;
      case "comedy":
        return AppLocalizations.of(context)!.comedy;
      case "adventure":
        return AppLocalizations.of(context)!.adventure;
      case "horror":
        return AppLocalizations.of(context)!.horror;
      case "crime":
        return AppLocalizations.of(context)!.crime;
      case "romance":
        return AppLocalizations.of(context)!.romance;
      case "animation":
        return AppLocalizations.of(context)!.animation;
      case "thriller":
        return AppLocalizations.of(context)!.thriller;
      case "mystery":
        return AppLocalizations.of(context)!.mystery;
      case "music":
        return AppLocalizations.of(context)!.music;
      default:
        return genre;
    }
  }

  @override
  Widget build(BuildContext context) {
    final genres = widget.movies
        .expand((movie) => movie.genres)
        .toSet()
        .toList();

    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            widget.movies[selectedIndex].posterImage,
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.70),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const SectionTitle(isAvailableNow: true),
              const SizedBox(height: 8),
              SizedBox(
                height: 357,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: widget.movies.length,
                  onPageChanged: (idx) => setState(() => selectedIndex = idx),
                  itemBuilder: (context, idx) => MovieCard(
                    movie: widget.movies[idx],
                    isSelected: idx == selectedIndex,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SectionTitle(isAvailableNow: false),
              const SizedBox(height: 16),

              ...genres.map((genre) {
                final genreMovies = widget.movies
                    .where((e) => e.genres.contains(genre))
                    .toList();

                if (genreMovies.isEmpty) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                      child: Row(
                        children: [
                          Text(
                            _getTranslatedGenre(context, genre),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.seeMore,
                                  style: const TextStyle(
                                    color: MColors.yellow,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: MColors.yellow,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        itemCount: genreMovies.length,
                        itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: AspectRatio(
                              aspectRatio: 0.70,
                              child: Stack(
                                children: [
                                  Image.network(
                                    genreMovies[i].posterImage,
                                    fit: BoxFit.cover,
                                    width: 107,
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: MColors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            MIcons.star,
                                            width: 13,
                                            height: 13,
                                            color: MColors.yellow,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            "${genreMovies[i].rating}",
                                            style: const TextStyle(
                                              color: MColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }),
            ],
          )

        ),
      ],
    );
  }
}
