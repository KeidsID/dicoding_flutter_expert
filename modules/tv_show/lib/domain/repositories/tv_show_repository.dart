import 'package:dartz/dartz.dart';

import 'package:core/common/failure.dart';
import '../entities/tv_show.dart';
import '../entities/tv_show_detail.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getAiringTodayTvShows({int page = 1});
  Future<Either<Failure, List<TvShow>>> getPopularTvShows({int page = 1});
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows({int page = 1});
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);
  Future<Either<Failure, String>> saveToWatchlist(TvShowDetail tvShow);
  Future<Either<Failure, String>> removeFromWatchlist(TvShowDetail tvShow);
  Future<bool> isWatchlisted(int id);
  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows();
}
