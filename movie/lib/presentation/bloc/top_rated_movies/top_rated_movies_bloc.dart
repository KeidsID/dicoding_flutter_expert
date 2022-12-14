import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc(this.getTopRatedMovies)
      : super(TopRatedMoviesState.init()) {
    on<OnFetchingTopRatedMovies>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));
      final results = await getTopRatedMovies.execute();

      results.fold(
        (l) => emit(state.copyWith(
          state: RequestState.error,
          msg: l.message,
        )),
        (r) => emit(state.copyWith(
          state: RequestState.loaded,
          results: r,
        )),
      );
    });
  }
}
