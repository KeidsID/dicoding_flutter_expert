import '../repositories/tv_show_repository.dart';

class GetTvShowWatchlistStatus {
  GetTvShowWatchlistStatus(this.repo);

  final TvShowRepository repo;

  Future<bool> execute(int id) {
    return repo.isWatchlisted(id);
  }
}
