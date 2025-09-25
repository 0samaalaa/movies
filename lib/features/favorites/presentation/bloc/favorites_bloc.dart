import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';
import '../../domain/usecases/add_favorite.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/is_favorite.dart';
import '../../domain/usecases/remove_favorite.dart';
import '../../domain/entities/favorite_movie_entity.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavorites getFavorites;
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;
  final IsFavorite isFavorite;

  FavoritesBloc({
    required this.getFavorites,
    required this.addFavorite,
    required this.removeFavorite,
    required this.isFavorite,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddMovieToFavorites>(_onAddFavorite);
    on<RemoveMovieFromFavorites>(_onRemoveFavorite);
    on<CheckIfFavorite>(_onCheckIfFavorite);
  }

  Future<void> _onLoadFavorites(
      LoadFavorites event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    try {
      final favorites = await getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onAddFavorite(
      AddMovieToFavorites event, Emitter<FavoritesState> emit) async {
    try {
      final movie = FavoriteMovie(
        movieId: event.movieId,
        title: event.title,
        rating: event.rating,
        posterImage: event.posterImage,
        year: event.year,
      );

      await addFavorite(movie);
      add(LoadFavorites());
      add(CheckIfFavorite(movie.movieId));
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        add(CheckIfFavorite(event.movieId));
      } else {
        emit(FavoritesError("Failed to add favorite: ${e.message}"));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }


  Future<void> _onRemoveFavorite(
      RemoveMovieFromFavorites event, Emitter<FavoritesState> emit) async {
    try {
      await removeFavorite(event.movieId);
      add(LoadFavorites());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onCheckIfFavorite(
      CheckIfFavorite event, Emitter<FavoritesState> emit) async {
    try {
      final result = await isFavorite(event.movieId);
      emit(FavoriteStatus(result));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
