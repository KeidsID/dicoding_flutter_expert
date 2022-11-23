import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv_show.dart';
import '../entities/tv_show_detail.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getOnAirTvShows();
  Future<Either<Failure, List<TvShow>>> getPopularTvShows();
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);
  Future<Either<Failure, String>> saveTvShowToWatchlist(TvShowDetail tvShow);
  Future<Either<Failure, String>> removeTvShowFromWatchlist(TvShowDetail tvShow);
  Future<bool> isWatchlisted(int id);
  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows();
}
