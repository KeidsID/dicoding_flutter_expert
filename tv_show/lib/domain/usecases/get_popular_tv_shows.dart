import 'package:dartz/dartz.dart';

import 'package:core/common/failure.dart';
import '../entities/tv_show.dart';
import '../repositories/tv_show_repository.dart';

class GetPopularTvShows {
  GetPopularTvShows(this.repo);

  final TvShowRepository repo;

  Future<Either<Failure, List<TvShow>>> execute({int page = 1}) {
    return repo.getPopularTvShows(page: page);
  }
}
