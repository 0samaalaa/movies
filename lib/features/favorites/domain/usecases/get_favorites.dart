import '../entities/favorite_movie_entity.dart';
import '../repositories/favorites_repository.dart';

class GetFavorites {
  final FavoritesRepository repository;

  GetFavorites(this.repository);

  Future<List<FavoriteMovie>> call() async {
    return repository.getFavorites();
  }
}
