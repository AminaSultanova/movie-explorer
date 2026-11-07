import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<SearchMoviesEvent>(_onSearchMovies);
  }

  Future<void> _onFetchMovies(
    FetchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());
    try {
      final movies = await movieRepository.fetchMovies();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('Failed to load movies. Please try again.'));
    }
  }

  Future<void> _onSearchMovies(
    SearchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      add(FetchMoviesEvent());
      return;
    }
    emit(MovieLoading());
    try {
      final movies = await movieRepository.searchMovies(event.query);
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('Nothing found for "${event.query}".'));
    }
  }
}
