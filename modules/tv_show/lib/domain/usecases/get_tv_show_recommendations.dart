import 'package:dartz/dartz.dart';

import 'package:core/common/failure.dart';
import '../entities/tv_show.dart';
import '../repositories/tv_show_repository.dart';

class GetTvShowRecommendations {
  GetTvShowRecommendations(this.repo);

  final TvShowRepository repo;

  Future<Either<Failure, List<TvShow>>> execute(int id) {
    return repo.getTvShowRecommendations(id);
  }
}
