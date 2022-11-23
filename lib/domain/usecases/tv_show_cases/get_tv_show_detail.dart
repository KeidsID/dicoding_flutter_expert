import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv_show_detail.dart';
import '../../repositories/tv_show_repository.dart';

class GetTvShowDetail {
  GetTvShowDetail(this.repo);

  final TvShowRepository repo;

  Future<Either<Failure, TvShowDetail>> execute(int id) {
    return repo.getTvShowDetail(id);
  }
}
