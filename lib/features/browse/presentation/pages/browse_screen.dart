import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../home/presentation/bloc/movie_bloc.dart';
import '../../../home/presentation/bloc/movie_event.dart';
import '../../../home/presentation/bloc/movie_state.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int selectedGenre = 0;

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(LoadMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final genres = [
      AppLocalizations.of(context)!.action,
      AppLocalizations.of(context)!.adventure,
      AppLocalizations.of(context)!.animation,
      AppLocalizations.of(context)!.biography,
      AppLocalizations.of(context)!.comedy,
      AppLocalizations.of(context)!.crime,
      AppLocalizations.of(context)!.drama,
      AppLocalizations.of(context)!.fantasy,
      AppLocalizations.of(context)!.horror,
    ];
    return Scaffold(
      backgroundColor: MColors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50,left: 16,right: 16),
            child: SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                itemCount: genres.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final isSelected = index == selectedGenre;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGenre = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSelected ? MColors.yellow : Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: MColors.yellow,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      child: Text(
                        genres[index],
                        style: TextStyle(
                          color: isSelected ? Colors.black : MColors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator(color: MColors.yellow));
                } else if (state is MovieLoaded) {
                  final movies = state.movies;
                  if (movies.isEmpty) {
                    return const Center(
                      child: Text(
                        "No movies found",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: GridView.builder(
                      itemCount: movies.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, idx) {
                        final movie = movies[idx];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  movie.posterImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(color: Colors.grey[900]),
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.75),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        MIcons.star,
                                        width: 14,
                                        height: 14,
                                        color: MColors.yellow,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        "${movie.rating}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is MovieError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
