import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/resources/app_images.dart';
import '../../../movie_details/presentation/pages/movie_details.dart';
import '../../data/datasources/movie_remote_datasource.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/get_movies.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../widgets/searchbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<SearchBloc>().add(LoadMoreMoviesEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return RepositoryProvider(
      create: (_) => MovieRepositoryImpl(MovieRemoteDatasource()),
      child: BlocProvider(
        create: (context) => SearchBloc(
          GetMovies(RepositoryProvider.of<MovieRepositoryImpl>(context)),
        ),
        child: Scaffold(
          backgroundColor: MColors.black,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: Column(
              children: [
                SearchBarWidget(controller: controller),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchInitial) {
                        return Center(
                          child: Image.asset(
                            MImages.popcorn,
                            width: 120,
                            height: 120,
                          ),
                        );
                      } else if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: MColors.yellow,
                          ),
                        );
                      } else if (state is SearchSuccess ||
                          state is SearchLoadingMore) {
                        final movies = state is SearchSuccess
                            ? state.movies
                            : (state as SearchLoadingMore).movies;

                        if (movies.isEmpty) {
                          return Center(
                            child: Text(
                              l10n.noMoviesfound,
                              style: const TextStyle(color: MColors.white),
                            ),
                          );
                        }

                        return GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: movies.length +
                              (state is SearchLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= movies.length) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: MColors.yellow,
                                ),
                              );
                            }

                            final movie = movies[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        MovieDetailsScreen(movieId: movie.id),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.network(
                                        movie.mediumCoverImage,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            Container(color: MColors.dgrey),
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: MColors.black.withOpacity(0.7),
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(MIcons.star,
                                                color: MColors.yellow,
                                                width: 15),
                                            const SizedBox(width: 3),
                                            Text(
                                              " ${movie.rating}",
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
                            );
                          },
                        );
                      } else if (state is SearchError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: MColors.red),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
