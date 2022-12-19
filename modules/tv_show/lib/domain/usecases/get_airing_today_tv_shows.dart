import 'package:dartz/dartz.dart';

import 'package:core/common/failure.dart';
import '../entities/tv_show.dart';
import '../repositories/tv_show_repository.dart';

class GetAiringTodayTvShows {
  GetAiringTodayTvShows(this.repo);

  final TvShowRepository repo;

  Future<Either<Failure, List<TvShow>>> execute({int page = 1}) {
    return repo.getAiringTodayTvShows(page: page);
  }
}
