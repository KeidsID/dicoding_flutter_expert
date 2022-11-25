import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_show_remote_data_source.dart';
import 'package:ditonton/domain/entities/tv_show.dart';

import 'package:ditonton/common/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/tv_show_repository.dart';

class TvShowRepositoryImpl implements TvShowRepository {
  TvShowRepositoryImpl({
    required this.remoteDataSource,
  });

  final TvShowRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<TvShow>>> getOnAirTvShows() async {
    try {
      final result = await remoteDataSource.getOnAirTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getPopularTvShows() async {
    try {
      final result = await remoteDataSource.getPopularTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows() async {
    try {
      final result = await remoteDataSource.getTopRatedTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
