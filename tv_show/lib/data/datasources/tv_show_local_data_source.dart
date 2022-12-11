import 'package:core/common/exception.dart';
import '../datasources/db/tv_show_db_helper.dart';
import '../models/tv_show_table.dart';

abstract class TvShowLocalDataSource {
  Future<String> insertWatchlist(TvShowTable tvShow);
  Future<String> removeWatchlist(TvShowTable tvShow);
  Future<TvShowTable?> getTvShowById(int id);
  Future<List<TvShowTable>> getWatchlistTvShows();
}

class TvShowLocalDataSourceImpl extends TvShowLocalDataSource {
  TvShowLocalDataSourceImpl({required this.dbHelper});

  final TvShowDbHelper dbHelper;

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    final result = await dbHelper.getTvShowById(id);

    if (result == null) return null;
    return TvShowTable.fromDb(result);
  }

  @override
  Future<List<TvShowTable>> getWatchlistTvShows() async {
    final result = await dbHelper.getWatchlistTvShows();

    return result.map((e) => TvShowTable.fromDb(e)).toList();
  }

  @override
  Future<String> insertWatchlist(TvShowTable tvShow) async {
    try {
      await dbHelper.insertWatchlist(tvShow);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException('$e');
    }
  }

  @override
  Future<String> removeWatchlist(TvShowTable tvShow) async {
    try {
      await dbHelper.removeWatchlist(tvShow);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException('$e');
    }
  }
}
