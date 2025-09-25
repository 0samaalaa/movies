import '../../domain/entities/favorite_movie_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_remote_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteSource remoteSource;

  FavoritesRepositoryImpl(this.remoteSource);

  @override
  Future<void> addFavorite(FavoriteMovie movie) {
    return remoteSource.addFavorite(movie: movie);
  }

  @override
  Future<List<FavoriteMovie>> getFavorites() {
    return remoteSource.getFavorites();
  }

  @override
  Future<void> removeFavorite(String movieId) {
    return remoteSource.removeFavorite(movieId);
  }

  @override
  Future<bool> isFavorite(String movieId) {
    return remoteSource.isFavorite(movieId);
  }
}
