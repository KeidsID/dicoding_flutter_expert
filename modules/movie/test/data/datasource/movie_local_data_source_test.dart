import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/common/exception.dart';
import 'package:movie/data/data_source/movie_local_data_source.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helper/mock_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockMovieDbHelper dbHelper;

  setUp(() {
    dbHelper = MockMovieDbHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: dbHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(dbHelper.insertWatchlist(dummyMovieTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(dummyMovieTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(dbHelper.insertWatchlist(dummyMovieTable)).thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(dummyMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(dbHelper.removeWatchlist(dummyMovieTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(dummyMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(dbHelper.removeWatchlist(dummyMovieTable)).thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(dummyMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(dbHelper.getMovieById(tId)).thenAnswer((_) async => dummyMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, dummyMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(dbHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(dbHelper.getWatchlistMovies())
          .thenAnswer((_) async => [dummyMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [dummyMovieTable]);
    });
  });
}
