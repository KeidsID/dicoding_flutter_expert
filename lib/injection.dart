import 'package:ditonton/data/datasources/tv_show_remote_data_source.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_airing_today_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_top_rated_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/search_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv_show/popular_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show/top_rated_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show/tv_show_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show/tv_show_list_notifier.dart.dart';
import 'package:ditonton/presentation/provider/tv_show/tv_show_search_notifier.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movie_local_data_source.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';

import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/movie_cases/get_movie_detail.dart';
import 'domain/usecases/movie_cases/get_movie_recommendations.dart';
import 'domain/usecases/movie_cases/get_now_playing_movies.dart';
import 'domain/usecases/movie_cases/get_popular_movies.dart';
import 'domain/usecases/movie_cases/get_top_rated_movies.dart';
import 'domain/usecases/movie_cases/get_watchlist_movies.dart';
import 'domain/usecases/movie_cases/get_watchlist_status.dart';
import 'domain/usecases/movie_cases/remove_watchlist.dart';
import 'domain/usecases/movie_cases/save_watchlist.dart';
import 'domain/usecases/movie_cases/search_movies.dart';

import 'presentation/provider/movie_detail_notifier.dart';
import 'presentation/provider/movie_list_notifier.dart';
import 'presentation/provider/movie_search_notifier.dart';
import 'presentation/provider/popular_movies_notifier.dart';
import 'presentation/provider/top_rated_movies_notifier.dart';
import 'presentation/provider/watchlist_movie_notifier.dart';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TvShowListNotifier(
      getOnAirTvShows: locator(),
      getPopularTvShows: locator(),
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvShowsNotifier(
      getPopularTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvShowsNotifier(
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowDetailNotifier(
      getTvShowDetail: locator(),
      getTvShowRecommendations: locator(),
    ),
  );
  locator.registerFactory(() => TvShowSearchNotifier(searchTvShows: locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetAiringTodayTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
