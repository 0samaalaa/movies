import '../entities/favorite_movie_entity.dart';
import '../repositories/favorites_repository.dart';

class AddFavorite {
  final FavoritesRepository repository;

  AddFavorite(this.repository);

  Future<void> call(FavoriteMovie movie) async {
    return repository.addFavorite(movie);
  }
}
