part of 'watchlist_tv_show_bloc.dart';

abstract class WatchlistTvShowEvent {
  const WatchlistTvShowEvent();
}

class OnFetchWatchlistTvShows extends WatchlistTvShowEvent {
  const OnFetchWatchlistTvShows();
}
