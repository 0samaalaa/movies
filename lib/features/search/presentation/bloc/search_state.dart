import '../../domain/entities/movie.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoadingMore extends SearchState {
  final List<Movie> movies;
  SearchLoadingMore(this.movies);
}

class SearchSuccess extends SearchState {
  final List<Movie> movies;
  final int page;
  final bool hasReachedMax;
  final String query;

  SearchSuccess({
    required this.movies,
    required this.page,
    required this.hasReachedMax,
    required this.query,
  });

  SearchSuccess copyWith({
    List<Movie>? movies,
    int? page,
    bool? hasReachedMax,
    String? query,
  }) {
    return SearchSuccess(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      query: query ?? this.query,
    );
  }
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
