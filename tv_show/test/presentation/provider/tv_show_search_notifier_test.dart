import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/presentation/provider/tv_show_search_notifier.dart';

import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/tv_show_usecase_helper.mocks.dart';

void main() {
  late TvShowSearchNotifier prov;
  late int notifyCount;
  late MockSearchTvShows mockUsecase;

  setUp(() {
    notifyCount = 0;
    mockUsecase = MockSearchTvShows();
    prov = TvShowSearchNotifier(searchTvShows: mockUsecase)
      ..addListener(() => ++notifyCount);
  });

  const query = 'lmao';

  group('TvShowSearchNotifier', () {
    test('test: Every property initializes empty state', () {
      expect(prov.results, <TvShow>[]);
      expect(prov.state, RequestState.empty);
      expect(prov.msg, '');
    });
    group('.fetchSearchResults() test:', () {
      test('Loading data condition', () {
        when(mockUsecase.execute(query)).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        prov.fetchSearchResults(query);

        expect(prov.state, RequestState.loading);
        expect(notifyCount, 1);
      });
      test('The condition when fetching data is successful', () async {
        when(mockUsecase.execute(query)).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        await prov.fetchSearchResults(query);

        expect(prov.state, RequestState.loaded);
        expect(prov.results, [dummyTvShow]);
        expect(notifyCount, 2);
      });
      test('The condition when fetching data is fail\n', () async {
        when(mockUsecase.execute(query)).thenAnswer(
          (_) async => const Left(ServerFailure('')),
        );

        await prov.fetchSearchResults(query);

        expect(prov.state, RequestState.error);
        expect(prov.msg, '');
        expect(notifyCount, 2);
      });
    });
  });
}
