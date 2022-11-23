import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv_show.dart';
import '../../repositories/tv_show_repository.dart';

class GetTopRatedTvShows {
  GetTopRatedTvShows(this.repo);

  final TvShowRepository repo;

  Future<Either<Failure, List<TvShow>>> execute() => repo.getTopRatedTvShows();
}
