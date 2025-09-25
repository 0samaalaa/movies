abstract class MovieDetailsEvent {}

class FetchMovieDetailsEvent extends MovieDetailsEvent {
  final int movieId;
  FetchMovieDetailsEvent(this.movieId);
}

