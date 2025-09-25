import 'package:equatable/equatable.dart';
import '../../domain/entities/favorite_movie_entity.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteMovie> favorites;

  const FavoritesLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoriteStatus extends FavoritesState {
  final bool isFavorite;

  const FavoriteStatus(this.isFavorite);

  @override
  List<Object?> get props => [isFavorite];
}
