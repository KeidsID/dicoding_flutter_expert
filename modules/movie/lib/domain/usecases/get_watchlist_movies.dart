import '../entities/movie.dart';
import '../repo/movie_repository.dart';

import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
