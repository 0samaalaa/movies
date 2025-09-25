import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/home/presentation/widgets/section_title.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/routes/routes.dart';
import '../../../layout/presentation/cubit/Layout_cubit.dart';
import '../../domain/entities/movie.dart';
import '../../../layout/presentation/pages/layout_screen.dart';
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
    final l10n = AppLocalizations.of(context)!;
    switch (genre.toLowerCase()) {
      case "action":
        return l10n.action;
      case "adventure":
        return l10n.adventure;
      case "animation":
        return l10n.animation;
      case "biography":
        return l10n.biography;
      case "comedy":
        return l10n.comedy;
      case "crime":
        return l10n.crime;
      case "documentary":
        return l10n.documentary;
      case "drama":
        return l10n.drama;
      case "family":
        return l10n.family;
      case "fantasy":
        return l10n.fantasy;
      case "film-noir":
        return l10n.filmNoir;
      case "game-show":
        return l10n.gameShow;
      case "history":
        return l10n.history;
      case "horror":
        return l10n.horror;
      case "music":
        return l10n.music;
      case "musical":
        return l10n.musical;
      case "mystery":
        return l10n.mystery;
      case "news":
        return l10n.news;
      case "reality-tv":
        return l10n.realityTV;
      case "romance":
        return l10n.romance;
      case "sci-fi":
        return l10n.sciFi;
      case "sport":
        return l10n.sport;
      case "talk-show":
        return l10n.talkShow;
      case "thriller":
        return l10n.thriller;
      case "war":
        return l10n.war;
      case "western":
        return l10n.western;
      default:
        return genre;
    }
  }

  @override
  Widget build(BuildContext context) {
    final genres = widget.movies
        .expand((movie) => movie.genres)
        .toSet()
        .toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            widget.movies[selectedIndex].poster,
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
                  itemBuilder: (context, idx) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.movieDetailsScreen,
                        arguments: {'movieId': widget.movies[idx].id},
                      );
                    },
                    child: MovieCard(
                      movie: widget.movies[idx],
                      isSelected: idx == selectedIndex,
                    ),
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
                              color: MColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              context.read<LayoutCubit>().changeTab(2, genre: genre);
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
                itemBuilder: (context, i) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.movieDetailsScreen,
                    arguments: {'movieId': genreMovies[i].id},
                  );
                },
                child: Padding(
                padding: const EdgeInsets.only(right: 18),
                child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                aspectRatio: 0.70,
                child: Stack(
                children: [
                Image.network(
                genreMovies[i].poster,
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
                         Image.asset(MIcons.star,
                             color: MColors.yellow,
                             width: 15),
                         const SizedBox(width: 3),
                         Text(
                           " ${genreMovies[i].rating}",
                           style: const TextStyle(
                             color: MColors.white,
                             fontSize: 16,
                             fontWeight: FontWeight.w600,
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
                ),), ),
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
