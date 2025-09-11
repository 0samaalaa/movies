import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;

  MovieBloc(this.getMovies) : super(MovieLoading()) {
    on<LoadMoviesEvent>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await getMovies();
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError('Failed to load movies'));
      }
    });
  }
}
