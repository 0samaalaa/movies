import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_movies.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetMovies getMovies;

  SearchBloc(this.getMovies) : super(SearchInitial()) {
    on<SearchMovieEvent>(_onSearchMovie);
    on<LoadMoreMoviesEvent>(_onLoadMoreMovies);
  }

  Future<void> _onSearchMovie(
      SearchMovieEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final movies = await getMovies(query: event.query, page: 1);

      emit(SearchSuccess(
        movies: movies,
        page: 1,
        hasReachedMax: movies.isEmpty,
        query: event.query,
      ));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onLoadMoreMovies(
      LoadMoreMoviesEvent event, Emitter<SearchState> emit) async {
    if (state is SearchSuccess) {
      final currentState = state as SearchSuccess;
      if (currentState.hasReachedMax) return;

      emit(SearchLoadingMore(currentState.movies));

      try {
        final nextPage = currentState.page + 1;
        final movies =
        await getMovies(query: currentState.query, page: nextPage);

        if (movies.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(currentState.copyWith(
            movies: List.of(currentState.movies)..addAll(movies),
            page: nextPage,
            hasReachedMax: false,
          ));
        }
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    }
  }
}
