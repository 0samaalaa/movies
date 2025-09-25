import '../entities/favorite_movie_entity.dart';

abstract class FavoritesRepository {
  Future<void> addFavorite(FavoriteMovie movie);
  Future<List<FavoriteMovie>> getFavorites();
  Future<void> removeFavorite(String movieId);
  Future<bool> isFavorite(String movieId);
}
