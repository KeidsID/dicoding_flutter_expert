part of 'airing_today_tv_shows_bloc.dart';

abstract class AiringTodayTvShowsState extends Equatable {
  const AiringTodayTvShowsState();

  @override
  List<Object> get props => [];
}

class InitState extends AiringTodayTvShowsState {
  const InitState();
}

class Loading extends AiringTodayTvShowsState {
  const Loading();
}

class HasData extends AiringTodayTvShowsState {
  final List<TvShow> results;

  const HasData(this.results);

  @override
  List<Object> get props => [results];
}

class Error extends AiringTodayTvShowsState {
  final String msg;

  const Error(this.msg);

  @override
  List<Object> get props => [msg];
}
