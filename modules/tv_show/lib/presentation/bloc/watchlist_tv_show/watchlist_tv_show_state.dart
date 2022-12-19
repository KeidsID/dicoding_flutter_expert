part of 'watchlist_tv_show_bloc.dart';

abstract class WatchlistTvShowState extends Equatable {
  const WatchlistTvShowState();

  @override
  List<Object> get props => [];
}

class InitState extends WatchlistTvShowState {
  const InitState();
}

class Loading extends WatchlistTvShowState {
  const Loading();
}

class HasData extends WatchlistTvShowState {
  final List<TvShow> results;

  const HasData(this.results);

  @override
  List<Object> get props => [results];
}

class Error extends WatchlistTvShowState {
  final String msg;

  const Error(this.msg);

  @override
  List<Object> get props => [msg];
}
