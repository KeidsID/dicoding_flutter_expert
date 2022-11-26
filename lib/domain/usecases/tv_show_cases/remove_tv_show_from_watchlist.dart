import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../../data/models/tv_show_models/tv_show_detail_model.dart';
import '../../repositories/tv_show_repository.dart';

class RemoveTvShowFromWatchlist {
  RemoveTvShowFromWatchlist(this.repo);

  final TvShowRepository repo;

  Future<Either<Failure, String>> execute(TvShowDetailModel tvShow) {
    return repo.removeTvShowFromWatchlist(tvShow);
  }
}
