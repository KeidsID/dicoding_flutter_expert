import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/movie_usecases.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const successAddToDbMsg = 'Added to Watchlist';
  static const successRemoveFromDbMsg = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchListStatus,
  }) : super(MovieDetailState.init()) {
    on<OnDidChangeDep>((event, emit) => emit(MovieDetailState.init()));

    on<OnFetchDetail>((event, emit) async {
      final id = event.id;

      emit(state.copyWith(
        blocState: RequestState.loading,
      ));

      final getDetail = await getMovieDetail.execute(id);
      final getRecomms = await getMovieRecommendations.execute(id);

      getDetail.fold(
        (fail) => emit(state.copyWith(
          blocState: RequestState.error,
          blocStateMsg: fail.message,
        )),
        (detail) {
          getRecomms.fold(
            (fail) => emit(state.copyWith(
              blocState: RequestState.error,
              blocStateMsg: fail.message,
            )),
            (recomms) => emit(state.copyWith(
              blocState: RequestState.loaded,
              movieDetail: detail,
              recomms: recomms,
            )),
          );
        },
      );
    });

    on<OnLoadDbStatus>((event, emit) async {
      final id = event.id;
      final msg = event.msg ?? '';
      final getStatus = await getWatchListStatus.execute(id);

      emit(state.copyWith(watchlistStatus: getStatus, watchlistMsg: msg));
    });

    on<OnAddToDb>((event, emit) async {
      final movie = event.movie;
      final addToDbMsg = await saveWatchlist.execute(movie);

      late String msg;

      addToDbMsg.fold(
        (l) => msg = l.message,
        (r) => msg = r,
      );

      add(OnLoadDbStatus(movie.id, msg: msg));
    });

    on<OnRemoveFromDb>((event, emit) async {
      final movie = event.movie;
      final removeFromDb = await removeWatchlist.execute(movie);

      late String msg;

      removeFromDb.fold(
        (l) => msg = l.message,
        (r) => msg = r,
      );

      add(OnLoadDbStatus(movie.id, msg: msg));
    });
  }
}
