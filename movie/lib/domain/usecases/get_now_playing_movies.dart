import '../entities/movie.dart';
import '../repo/movie_repository.dart';

import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
