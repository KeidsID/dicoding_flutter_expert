import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';

import '../datasources/tv_show_remote_data_source.dart';
import '../models/tv_show_table.dart';
import '../../data/datasources/tv_show_local_data_source.dart';
import '../../domain/entities/tv_show.dart';
import '../../domain/entities/tv_show_detail.dart';
import '../../domain/repositories/tv_show_repository.dart';

class TvShowRepositoryImpl implements TvShowRepository {
  TvShowRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final TvShowRemoteDataSource remoteDataSource;
  final TvShowLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<TvShow>>> getAiringTodayTvShows({
    int page = 1,
  }) async {
    try {
      final result = await remoteDataSource.getAiringTodayTvShows(page: page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getPopularTvShows({
    int page = 1,
  }) async {
    try {
      final result = await remoteDataSource.getPopularTvShows(page: page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows({
    int page = 1,
  }) async {
    try {
      final result = await remoteDataSource.getTopRatedTvShows(page: page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvShowDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvShowRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query) async {
    try {
      final result = await remoteDataSource.searchTvShows(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows() async {
    final result = await localDataSource.getWatchlistTvShows();

    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<bool> isWatchlisted(int id) async {
    final result = await localDataSource.getTvShowById(id);

    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeFromWatchlist(
    TvShowDetail tvShow,
  ) async {
    try {
      final result = await localDataSource.removeWatchlist(
        TvShowTable.fromEntity(tvShow),
      );

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveToWatchlist(TvShowDetail tvShow) async {
    try {
      final result = await localDataSource.insertWatchlist(
        TvShowTable.fromEntity(tvShow),
      );

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }
}
