part of 'top_rated_tv_shows_bloc.dart';

abstract class TopRatedTvShowsState extends Equatable {
  const TopRatedTvShowsState();

  @override
  List<Object> get props => [];
}

class InitState extends TopRatedTvShowsState {
  const InitState();
}

class Loading extends TopRatedTvShowsState {
  const Loading();
}

class HasData extends TopRatedTvShowsState {
  final List<TvShow> results;

  const HasData(this.results);

  @override
  List<Object> get props => [results];
}

class Error extends TopRatedTvShowsState {
  final String msg;

  const Error(this.msg);

  @override
  List<Object> get props => [msg];
}
