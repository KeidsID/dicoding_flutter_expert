part of 'popular_tv_shows_bloc.dart';

abstract class PopularTvShowsState extends Equatable {
  const PopularTvShowsState();

  @override
  List<Object> get props => [];
}

class InitState extends PopularTvShowsState {
  const InitState();
}

class Loading extends PopularTvShowsState {
  const Loading();
}

class HasData extends PopularTvShowsState {
  final List<TvShow> results;

  const HasData(this.results);

  @override
  List<Object> get props => [results];
}

class Error extends PopularTvShowsState {
  final String msg;

  const Error(this.msg);

  @override
  List<Object> get props => [msg];
}
