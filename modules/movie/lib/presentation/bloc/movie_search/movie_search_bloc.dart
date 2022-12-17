import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:core/common/utils.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/search_movies.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovie;

  MovieSearchBloc(this.searchMovie) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (ev, emit) async {
        final query = ev.query;

        emit(SearchLoading());
        final results = await searchMovie.execute(query);

        results.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchLoaded(data));
          },
        );
      },
      transformer: blocDebounceTime(const Duration(milliseconds: 500)),
    );
  }
}
