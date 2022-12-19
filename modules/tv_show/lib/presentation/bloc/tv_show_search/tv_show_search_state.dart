part of 'tv_show_search_bloc.dart';

abstract class TvShowSearchState extends Equatable {
  const TvShowSearchState();

  @override
  List<Object> get props => [];
}

class InitState extends TvShowSearchState {
  const InitState();
}

class Loading extends TvShowSearchState {
  const Loading();
}

class HasData extends TvShowSearchState {
  final List<TvShow> results;

  const HasData(this.results);

  @override
  List<Object> get props => [results];
}

class Error extends TvShowSearchState {
  final String msg;

  const Error(this.msg);

  @override
  List<Object> get props => [msg];
}
