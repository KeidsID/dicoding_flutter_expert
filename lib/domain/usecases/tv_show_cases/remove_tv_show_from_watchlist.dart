import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv_show_detail.dart';
import '../../repositories/tv_show_repository.dart';

class RemoveTvShowFromWatchlist {
  RemoveTvShowFromWatchlist(this.repo);

  final TvShowRepository repo;

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return repo.removeTvShowFromWatchlist(tvShow);
  }
}
