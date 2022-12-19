import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/entities/tv_show_detail.dart';
import 'package:tv_show/tv_show_usecases.dart';

part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  static const addToDbSuccessMsg = 'Added to Watchlist';
  static const removeFromDbSuccessMsg = 'Removed from Watchlist';

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetTvShowWatchlistStatus getTvShowWatchlistStatus;
  final SaveTvShowToWatchlist saveTvShowToWatchlist;
  final RemoveTvShowFromWatchlist removeTvShowFromWatchlist;

  TvShowDetailBloc({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getTvShowWatchlistStatus,
    required this.saveTvShowToWatchlist,
    required this.removeTvShowFromWatchlist,
  }) : super(TvShowDetailState.init()) {
    on<OnDidChangeDep>((_, emit) => emit(TvShowDetailState.init()));

    on<OnFetchDetail>((event, emit) async {
      final id = event.id;

      emit(state.copyWith(
        blocState: RequestState.loading,
      ));

      final getDetail = await getTvShowDetail.execute(id);
      final getRecomms = await getTvShowRecommendations.execute(id);

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
              tvShowDetail: detail,
              recomms: recomms,
            )),
          );
        },
      );
    });

    on<OnLoadDbStatus>((event, emit) async {
      final id = event.id;
      final msg = event.msg ?? '';
      final getStatus = await getTvShowWatchlistStatus.execute(id);

      emit(state.copyWith(watchlistStatus: getStatus, watchlistMsg: msg));
    });

    on<OnAddToDb>((event, emit) async {
      final movie = event.movie;
      final addToDbMsg = await saveTvShowToWatchlist.execute(movie);

      late String msg;

      addToDbMsg.fold(
        (l) => msg = l.message,
        (r) => msg = r,
      );

      add(OnLoadDbStatus(movie.id, msg: msg));
    });

    on<OnRemoveFromDb>((event, emit) async {
      final movie = event.movie;
      final removeFromDb = await removeTvShowFromWatchlist.execute(movie);

      late String msg;

      removeFromDb.fold(
        (l) => msg = l.message,
        (r) => msg = r,
      );

      add(OnLoadDbStatus(movie.id, msg: msg));
    });
  }
}
