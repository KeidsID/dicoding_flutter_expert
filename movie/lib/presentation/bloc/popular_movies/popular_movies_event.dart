part of 'popular_movies_bloc.dart';

abstract class PopularMoviesEvent {
  const PopularMoviesEvent();
}

class OnFetchingPopularMovies extends PopularMoviesEvent {
  const OnFetchingPopularMovies();
}
