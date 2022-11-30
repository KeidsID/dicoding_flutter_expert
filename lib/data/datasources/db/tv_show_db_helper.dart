import 'package:ditonton/data/models/tv_show_models/tv_show_table.dart';
import 'package:sqflite/sqflite.dart';

class TvShowDbHelper {
  factory TvShowDbHelper() => _instance ?? TvShowDbHelper._internal();

  TvShowDbHelper._internal() {
    _instance = this;
  }

  static TvShowDbHelper? _instance;
  static Database? _db;
  static const _tblWatchlist = 'watchlist';

  Future<Database?> get database async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    final dbDir = await getDatabasesPath();
    final dbPath = '$dbDir/tv_show.db';

    Database db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE $_tblWatchlist (
            id INTEGER PRIMARY KEY,
            name TEXT,
            overview TEXT,
            posterPath TEXT
          );
        ''');
      },
    );

    return db;
  }

  insertWatchlist(TvShowTable tvShow) async {
    final db = await database;

    return await db!.insert(_tblWatchlist, tvShow.toDb());
  }

  removeWatchlist(TvShowTable tvShow) async {
    final db = await database;

    return db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [tvShow.id],
    );
  }

  Future<Map<String, dynamic>?> getTvShowById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isEmpty) {
      return null;
    }

    return results.first;
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvShows() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
