import 'package:dartz/dartz.dart';

import 'package:core/common/failure.dart';
import '../entities/tv_show_detail.dart';
import '../repositories/tv_show_repository.dart';

class SaveTvShowToWatchlist {
  SaveTvShowToWatchlist(this.repo);

  final TvShowRepository repo;

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return repo.saveToWatchlist(tvShow);
  }
}
