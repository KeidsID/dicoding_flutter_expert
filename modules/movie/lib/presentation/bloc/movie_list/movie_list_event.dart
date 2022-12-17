part of 'movie_list_bloc.dart';

@immutable
abstract class MovieListEvent {
  const MovieListEvent();
}

class OnFetchingNowPlayingMovies extends MovieListEvent {
  const OnFetchingNowPlayingMovies();
}

class OnFetchingPopularMovies extends MovieListEvent {
  const OnFetchingPopularMovies();
}

class OnFetchingTopRatedMovies extends MovieListEvent {
  const OnFetchingTopRatedMovies();
}
