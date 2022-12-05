import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_show_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show/tv_show_dummy_obj.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowLocalDataSource dataSource;
  late MockTvShowDbHelper mockDbHelper;

  setUp(() {
    mockDbHelper = MockTvShowDbHelper();
    dataSource = TvShowLocalDataSourceImpl(dbHelper: mockDbHelper);
  });

  group('TvShowLocalDataSource', () {
    group('.insertWatchlist() test:', () {
      test('Return String when insert to database is success', () async {
        when(mockDbHelper.insertWatchlist(dummyTvTable))
            .thenAnswer((_) async => 1);

        final actual = await dataSource.insertWatchlist(dummyTvTable);

        expect(actual, 'Added to Watchlist');
      });
      test(
        'Throw DatabaseException when insert to database is failed\n',
        () async {
          when(mockDbHelper.insertWatchlist(dummyTvTable))
              .thenThrow(Exception());

          final actual = dataSource.insertWatchlist(dummyTvTable);

          expect(actual, throwsA(isA<DatabaseException>()));
        },
      );
    });
    group('.removeWatchlist() test:', () {
      test(
        'Return String when remove tv show from database is success',
        () async {
          when(mockDbHelper.removeWatchlist(dummyTvTable))
              .thenAnswer((_) async => 1);

          final actual = await dataSource.removeWatchlist(dummyTvTable);

          expect(actual, 'Removed from Watchlist');
        },
      );
      test(
        'Throw DatabaseException when remove tv show from database is failed\n',
        () async {
          when(mockDbHelper.removeWatchlist(dummyTvTable))
              .thenThrow(Exception());

          final actual = dataSource.removeWatchlist(dummyTvTable);

          expect(actual, throwsA(isA<DatabaseException>()));
        },
      );
    });
    group('.getWatchlistTvShows() test:', () {
      test('Return List<TvShowTable> from database\n', () async {
        when(mockDbHelper.getWatchlistTvShows())
            .thenAnswer((_) async => [dummyTvMap]);

        final actual = await dataSource.getWatchlistTvShows();

        expect(actual, [dummyTvTable]);
      });
    });
    group('.getTvShowById() test:', () {
      test('Return TvShowTable when data is found', () async {
        when(mockDbHelper.getTvShowById(1)).thenAnswer((_) async => dummyTvMap);

        final actual = await dataSource.getTvShowById(1);

        expect(actual, dummyTvTable);
      });

      test('Return null when data is not found', () async {
        when(mockDbHelper.getTvShowById(1)).thenAnswer((_) async => null);

        final actual = await dataSource.getTvShowById(1);

        expect(actual, null);
      });
    });
  });
}
