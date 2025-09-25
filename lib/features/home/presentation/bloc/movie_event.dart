abstract class MovieEvent {}

class LoadMoviesEvent extends MovieEvent {}

class FilterMoviesByGenreEvent extends MovieEvent {
  final String genre;
  FilterMoviesByGenreEvent(this.genre);
}
