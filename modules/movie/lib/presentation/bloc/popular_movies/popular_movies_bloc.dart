import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc(this.getPopularMovies) : super(PopularMoviesState.init()) {
    on<OnFetchingPopularMovies>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));
      final results = await getPopularMovies.execute();

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
