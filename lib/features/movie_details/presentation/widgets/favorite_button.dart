import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../favorites/domain/entities/favorite_movie_entity.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../../../favorites/presentation/bloc/favorites_event.dart';
import '../../../favorites/presentation/bloc/favorites_state.dart';
import '../../domain/entities/movie_details_entity.dart';

class FavoriteButton extends StatelessWidget {
  final MovieDetails details;
  const FavoriteButton({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        bool isSaved = false;
        if (state is FavoriteStatus) {
          isSaved = state.isFavorite;
        }
        return IconButton(
          icon: Image.asset(isSaved ? MIcons.saved : MIcons.save, width: 20),
          onPressed: () {
            final bloc = context.read<FavoritesBloc>();
            final movie = FavoriteMovie(
              movieId: details.id.toString(),
              title: details.title,
              rating: details.rating,
              posterImage: details.poster,
              year: details.year.toString(),
            );

            if (!isSaved) {
              bloc.add(AddMovieToFavorites(
                movieId: movie.movieId,
                title: movie.title,
                rating: movie.rating,
                posterImage: movie.posterImage,
                year: movie.year,
              ));
            } else {
              bloc.add(RemoveMovieFromFavorites(movie.movieId));
            }
          },
        );
      },
    );
  }
}
