import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddMovieToFavorites extends FavoritesEvent {
  final String movieId;
  final String title;
  final double rating;
  final String posterImage;
  final String year;

  const AddMovieToFavorites({
    required this.movieId,
    required this.title,
    required this.rating,
    required this.posterImage,
    required this.year,
  });

  @override
  List<Object?> get props => [movieId, title, rating, posterImage, year];
}

class RemoveMovieFromFavorites extends FavoritesEvent {
  final String movieId;

  const RemoveMovieFromFavorites(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class CheckIfFavorite extends FavoritesEvent {
  final String movieId;

  const CheckIfFavorite(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
