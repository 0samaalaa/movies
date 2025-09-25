import '../../domain/entities/movie_details_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetails details;
  final List<MovieSuggestion> suggestions;

  MovieDetailsLoaded(this.details, this.suggestions);
}

class FavoriteUpdated extends MovieDetailsState {
  final bool isFavorite;
  FavoriteUpdated(this.isFavorite);
}


class MovieDetailsError extends MovieDetailsState {
  final String message;
  MovieDetailsError(this.message);
}
