part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class InitState extends WatchlistMovieState {
  const InitState();
}

class Loading extends WatchlistMovieState {
  const Loading();
}

class HasData extends WatchlistMovieState {
  final List<Movie> results;

  const HasData(this.results);

  @override
  List<Object> get props => [results];
}

class Error extends WatchlistMovieState {
  final String msg;

  const Error(this.msg);

  @override
  List<Object> get props => [msg];
}
