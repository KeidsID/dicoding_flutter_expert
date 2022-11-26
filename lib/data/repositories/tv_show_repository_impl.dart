import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/entities/tv_show.dart';
import '../../domain/repositories/tv_show_repository.dart';
import '../datasources/tv_show_remote_data_source.dart';

class TvShowRepositoryImpl implements TvShowRepository {
  TvShowRepositoryImpl({
    required this.remoteDataSource,
  });

  final TvShowRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<TvShow>>> getAiringTodayTvShows() async {
    try {
      final result = await remoteDataSource.getAiringTodayTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
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
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
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
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvShowDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
