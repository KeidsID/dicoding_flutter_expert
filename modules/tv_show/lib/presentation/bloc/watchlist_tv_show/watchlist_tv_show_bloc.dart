import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/usecases/get_watchlist_tv_shows.dart';

import '../../../domain/entities/tv_show.dart';

part 'watchlist_tv_show_event.dart';
part 'watchlist_tv_show_state.dart';

class WatchlistTvShowBloc
    extends Bloc<WatchlistTvShowEvent, WatchlistTvShowState> {
  final GetWatchlistTvShows getWatchlistTvShows;

  WatchlistTvShowBloc(this.getWatchlistTvShows) : super(const InitState()) {
    on<OnFetchWatchlistTvShows>((event, emit) async {
      emit(const Loading());
      final getWatchlist = await getWatchlistTvShows.execute();

      getWatchlist.fold(
        (l) => emit(Error(l.message)),
        (r) => emit(HasData(r)),
      );
    });
  }
}
