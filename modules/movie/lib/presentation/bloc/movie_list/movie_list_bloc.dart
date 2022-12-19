import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:core/common/state_enum.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListState.init()) {
    on<OnFetchingNowPlayingMovies>((event, emit) async {
      emit(state.copyWith(npState: RequestState.loading));
      final results = await getNowPlayingMovies.execute();

      results.fold(
        (l) {
          emit(state.copyWith(npState: RequestState.error, msg: l.message));
        },
        (r) {
          emit(state.copyWith(npState: RequestState.loaded, npResults: r));
        },
      );
    });

    on<OnFetchingPopularMovies>((event, emit) async {
      emit(state.copyWith(popState: RequestState.loading));
      final results = await getPopularMovies.execute();

      results.fold(
        (l) {
          emit(state.copyWith(popState: RequestState.error, msg: l.message));
        },
        (r) {
          emit(state.copyWith(popState: RequestState.loaded, popResults: r));
        },
      );
    });

    on<OnFetchingTopRatedMovies>((event, emit) async {
      emit(state.copyWith(trState: RequestState.loading));
      final results = await getTopRatedMovies.execute();

      results.fold(
        (l) {
          emit(state.copyWith(trState: RequestState.error, msg: l.message));
        },
        (r) {
          emit(state.copyWith(trState: RequestState.loaded, trResults: r));
        },
      );
    });
  }
}
