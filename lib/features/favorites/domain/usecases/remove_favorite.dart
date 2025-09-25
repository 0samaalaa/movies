import '../repositories/favorites_repository.dart';

class RemoveFavorite {
  final FavoritesRepository repository;

  RemoveFavorite(this.repository);

  Future<void> call(String movieId) async {
    return repository.removeFavorite(movieId);
  }
}
