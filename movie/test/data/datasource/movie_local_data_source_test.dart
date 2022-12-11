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
      when(dbHelper.insertWatchlist(testMovieTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(dbHelper.insertWatchlist(testMovieTable)).thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(dbHelper.removeWatchlist(testMovieTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(dbHelper.removeWatchlist(testMovieTable)).thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(dbHelper.getMovieById(tId)).thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
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
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });
}
