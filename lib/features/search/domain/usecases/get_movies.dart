import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<List<Movie>> call({String? query, int page = 1}) {
    return repository.getMovies(query: query, page: page);
  }
}
