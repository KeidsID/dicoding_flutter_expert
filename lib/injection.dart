import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:movie/movie.dart';
import 'package:movie/data/data_source/db/movie_db_helper.dart';
import 'package:movie/data/data_source/movie_local_data_source.dart';
import 'package:movie/data/data_source/movie_remote_data_source.dart';
import 'package:movie/data/repo/movie_repository_impl.dart';
import 'package:movie/domain/repo/movie_repository.dart';

import 'package:tv_show/data/datasources/db/tv_show_db_helper.dart';
import 'package:tv_show/data/datasources/tv_show_local_data_source.dart';
import 'package:tv_show/data/datasources/tv_show_remote_data_source.dart';
import 'package:tv_show/data/repositories/tv_show_repository_impl.dart';
import 'package:tv_show/domain/repositories/tv_show_repository.dart';
import 'package:tv_show/tv_show.dart';

final locator = GetIt.instance;

void init() {
  // State Manager
  locator.registerFactory(
    () => MovieListBloc(
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
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
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
    () => AiringTodayTvShowsNotifier(
      getAiringTodayTvShows: locator(),
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
      getWatchlistStatus: locator(),
      saveToWatchliist: locator(),
      removeFromWatchlist: locator(),
    ),
  );
  locator.registerFactory(() => TvShowSearchNotifier(searchTvShows: locator()));
  locator.registerFactory(
    () => WatchlistTvShowNotifier(getWatchlistTvShows: locator()),
  );

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
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveTvShowToWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvShowFromWatchlist(locator()));

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
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvShowRemoteDataSource>(
    () => TvShowRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TvShowLocalDataSource>(
    () => TvShowLocalDataSourceImpl(dbHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<MovieDbHelper>(() => MovieDbHelper());
  locator.registerLazySingleton<TvShowDbHelper>(() => TvShowDbHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
