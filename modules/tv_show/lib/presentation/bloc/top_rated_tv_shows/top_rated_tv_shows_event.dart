part of 'top_rated_tv_shows_bloc.dart';

abstract class TopRatedTvShowsEvent extends Equatable {
  const TopRatedTvShowsEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvShows extends TopRatedTvShowsEvent {
  final int page;

  const OnFetchTvShows({this.page = 1});

  @override
  List<Object> get props => [page];
}
