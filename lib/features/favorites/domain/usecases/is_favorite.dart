import '../repositories/favorites_repository.dart';

class IsFavorite {
  final FavoritesRepository repository;

  IsFavorite(this.repository);

  Future<bool> call(String movieId) async {
    return repository.isFavorite(movieId);
  }
}
