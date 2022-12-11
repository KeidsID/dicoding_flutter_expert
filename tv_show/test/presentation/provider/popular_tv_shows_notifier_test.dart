import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/presentation/provider/popular_tv_shows_notifier.dart';

import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/tv_show_usecase_helper.mocks.dart';

void main() {
  late PopularTvShowsNotifier prov;
  late int notifyCount;
  late MockGetPopularTvShows mockUsecase;

  setUp(() {
    notifyCount = 0;
    mockUsecase = MockGetPopularTvShows();
    prov = PopularTvShowsNotifier(
      getPopularTvShows: mockUsecase,
    )..addListener(() => ++notifyCount);
  });

  const serverFailMsg = 'Server Failure';

  group('PopularTvShowsNotifier', () {
    test('test: Every property initializes empty state', () {
      expect(prov.result, <TvShow>[]);
      expect(prov.state, RequestState.empty);
      expect(prov.msg, '');
    });
    group('.fetchTvShows() test:', () {
      test('Loading data condition', () {
        when(mockUsecase.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        prov.fetchTvShows();

        expect(prov.state, RequestState.loading);
        expect(notifyCount, 1);
      });
      test('The condition when fetching data is successful', () async {
        when(mockUsecase.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        await prov.fetchTvShows();

        expect(prov.state, RequestState.loaded);
        expect(prov.result, [dummyTvShow]);
        expect(notifyCount, 2);
      });
      test('The condition when fetching data is fail\n', () async {
        when(mockUsecase.execute()).thenAnswer(
          (_) async => const Left(ServerFailure(serverFailMsg)),
        );

        await prov.fetchTvShows();

        expect(prov.state, RequestState.error);
        expect(prov.msg, serverFailMsg);
        expect(notifyCount, 2);
      });
    });
  });
}
