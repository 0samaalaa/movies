import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../home/presentation/bloc/movie_bloc.dart';
import '../../../home/presentation/bloc/movie_event.dart';
import '../../../home/presentation/bloc/movie_state.dart';
import '../../../layout/presentation/cubit/layout_cubit.dart';
import '../widgets/genere_tab_bar.dart';
import '../widgets/movie_grid.dart';

class BrowseScreen extends StatefulWidget {
  final String? initialGenre;
  const BrowseScreen({super.key, this.initialGenre});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int selectedGenre = 0;
  List<String> allGenres = ["all"];
  late ScrollController genreTabController;

  @override
  void initState() {
    super.initState();
    genreTabController = ScrollController();
    final state = context.read<MovieBloc>().state;
    if (state is! MovieLoaded) {
      context.read<MovieBloc>().add(LoadMoviesEvent());
    }
  }

  void loadGenresFromMovies(MovieLoaded state) {
    final genresFromMovies = state.movies
        .expand((m) => m.genres)
        .toSet()
        .toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    if (allGenres.length == 1) {
      setState(() {
        allGenres.addAll(genresFromMovies);
      });

      final layoutState = context.read<LayoutCubit>().state;
      final genreToSelect = layoutState.initialGenre ?? widget.initialGenre ?? "all";
      final idx = allGenres.indexOf(genreToSelect);
      if (idx != -1) {
        setState(() => selectedGenre = idx);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          scrollToSelectedTab(idx);
          _filterByGenre(allGenres[idx]);
        });
      }
    }
  }

  void scrollToSelectedTab(int index) {
    const double tabWidth = 90.0;
    final double screenWidth = MediaQuery.of(context).size.width;
    double offset = (tabWidth * index) - (screenWidth / 2) + (tabWidth / 2);
    if (offset < 0) offset = 0;
    if (genreTabController.hasClients) {
      final maxScroll = genreTabController.position.maxScrollExtent;
      if (offset > maxScroll) offset = maxScroll;

      genreTabController.animateTo(
        offset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  void _filterByGenre(String genre) {
    if (genre.toLowerCase() == "all") {
      context.read<MovieBloc>().add(LoadMoviesEvent());
    } else {
      context.read<MovieBloc>().add(FilterMoviesByGenreEvent(genre));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<LayoutCubit, LayoutState>(
      listenWhen: (previous, current) =>
      previous.initialGenre != current.initialGenre,
      listener: (context, state) {
        if (!mounted) return;
        final idx = state.initialGenre != null && allGenres.contains(state.initialGenre)
            ? allGenres.indexOf(state.initialGenre!)
            : 0;

        setState(() => selectedGenre = idx);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          scrollToSelectedTab(idx);
        });
        _filterByGenre(allGenres[idx]);
      },
      child: Scaffold(
        backgroundColor: MColors.black,
        body: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 15),
                child: BlocBuilder<MovieBloc, MovieState>(
                  buildWhen: (previous, current) => current is MovieLoaded,
                  builder: (context, state) {
                    if (state is MovieLoaded) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!mounted) return;
                        loadGenresFromMovies(state);
                      });
                    }
                    return GenreTabBar(
                      allGenres: allGenres,
                      selectedGenre: selectedGenre,
                      controller: genreTabController,
                      onGenreSelected: (index) {
                        setState(() => selectedGenre = index);
                        context.read<LayoutCubit>().setGenre(allGenres[index]);
                        scrollToSelectedTab(index);
                        _filterByGenre(allGenres[index]);
                      },
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<MovieBloc, MovieState>(
                buildWhen: (previous, current) =>
                current is MovieLoading || current is MovieLoaded,
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: MColors.yellow),
                    );
                  } else if (state is MovieLoaded) {
                    final movies = state.movies;
                    return MovieGrid(
                      movies: movies,
                      screenWidth: screenWidth,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
