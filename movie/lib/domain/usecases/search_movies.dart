import '../entities/movie.dart';
import '../repo/movie_repository.dart';

import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
