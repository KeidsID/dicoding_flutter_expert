part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent {
  const WatchlistMovieEvent();
}

class OnFetchWatchlistMovies extends WatchlistMovieEvent {
  const OnFetchWatchlistMovies();
}
