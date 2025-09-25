import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies({String? query, int page = 1});
}
