import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/usecases/get_airing_today_tv_shows.dart';
import 'package:tv_show/domain/usecases/get_popular_tv_shows.dart';
import 'package:tv_show/domain/usecases/get_top_rated_tv_shows.dart';

part 'tv_show_list_event.dart';
part 'tv_show_list_state.dart';

class TvShowListBloc extends Bloc<TvShowListEvent, TvShowListState> {
  final GetAiringTodayTvShows getAiringTodayTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  TvShowListBloc({
    required this.getAiringTodayTvShows,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  }) : super(TvShowListState.init()) {
    on<OnFetchAiringToday>((_, emit) async {
      emit(state.copyWith(atState: RequestState.loading));
      final usecase = await getAiringTodayTvShows.execute();

      usecase.fold(
        (l) => emit(state.copyWith(
          atState: RequestState.error,
          msg: l.message,
        )),
        (r) => emit(state.copyWith(
          atState: RequestState.loaded,
          atResults: r,
        )),
      );
    });

    on<OnFetchPopular>((_, emit) async {
      emit(state.copyWith(popState: RequestState.loading));
      final usecase = await getPopularTvShows.execute();

      usecase.fold(
        (l) => emit(state.copyWith(
          popState: RequestState.error,
          msg: l.message,
        )),
        (r) => emit(state.copyWith(
          popState: RequestState.loaded,
          popResults: r,
        )),
      );
    });

    on<OnFetchTopRated>((_, emit) async {
      emit(state.copyWith(trState: RequestState.loading));
      final usecase = await getTopRatedTvShows.execute();

      usecase.fold(
        (l) => emit(state.copyWith(
          trState: RequestState.error,
          msg: l.message,
        )),
        (r) => emit(state.copyWith(
          trState: RequestState.loaded,
          trResults: r,
        )),
      );
    });
  }
}
