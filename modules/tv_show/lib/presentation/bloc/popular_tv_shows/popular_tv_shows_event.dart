part of 'popular_tv_shows_bloc.dart';

abstract class PopularTvShowsEvent extends Equatable {
  const PopularTvShowsEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvShows extends PopularTvShowsEvent {
  final int page;

  const OnFetchTvShows({this.page = 1});

  @override
  List<Object> get props => [page];
}
