import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';

import '../../../domain/entities/movie.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc(this.getWatchlistMovies) : super(const InitState()) {
    on<OnFetchWatchlistMovies>((event, emit) async {
      emit(const Loading());
      final getWatchlist = await getWatchlistMovies.execute();

      getWatchlist.fold(
        (l) => emit(Error(l.message)),
        (r) => emit(HasData(r)),
      );
    });
  }
}
