part of 'airing_today_tv_shows_bloc.dart';

abstract class AiringTodayTvShowsEvent extends Equatable {
  const AiringTodayTvShowsEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvShows extends AiringTodayTvShowsEvent {
  final int page;

  const OnFetchTvShows({this.page = 1});

  @override
  List<Object> get props => [page];
}
