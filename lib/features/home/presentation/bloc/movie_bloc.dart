import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;
  List<Movie> _allMovies = [];

  MovieBloc(this.getMovies) : super(MovieLoading()) {
    on<LoadMoviesEvent>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await getMovies();
        _allMovies = movies;
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError('Failed to load movies'));
      }
    });

    on<FilterMoviesByGenreEvent>((event, emit) {
      if (_allMovies.isEmpty) {
        emit(MovieError('No movies loaded to filter'));
        return;
      }

      if (event.genre == "All") {
        emit(MovieLoaded(_allMovies));
      } else {
        final filtered =
        _allMovies.where((m) => m.genres.contains(event.genre)).toList();
        emit(MovieLoaded(filtered));
      }
    });
  }
}
