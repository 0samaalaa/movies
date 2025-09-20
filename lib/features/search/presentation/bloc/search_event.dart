abstract class SearchEvent {}

class SearchMovieEvent extends SearchEvent {
  final String query;
  SearchMovieEvent(this.query);
}

class LoadMoreMoviesEvent extends SearchEvent {}
