import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/presentation/provider/tv_show_list_notifier.dart.dart';

import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/tv_show_usecase_helper.mocks.dart';

void main() {
  late TvShowListNotifier prov;
  late int notifyCount;
  late MockGetAiringTodayTvShows mockGetAiringToday;
  late MockGetPopularTvShows mockGetPopular;
  late MockGetTopRatedTvShows mockGetTopRated;

  setUp(() {
    notifyCount = 0;
    mockGetAiringToday = MockGetAiringTodayTvShows();
    mockGetPopular = MockGetPopularTvShows();
    mockGetTopRated = MockGetTopRatedTvShows();
    prov = TvShowListNotifier(
      getOnAirTvShows: mockGetAiringToday,
      getPopularTvShows: mockGetPopular,
      getTopRatedTvShows: mockGetTopRated,
    )..addListener(() => ++notifyCount);
  });

  const serverFailMsg = 'Server Failure';

  group('TvShowListNotifier', () {
    test('test: Every state initializes RequestState.Empty', () {
      expect(prov.airingTodayState, RequestState.empty);
      expect(prov.popularState, RequestState.empty);
      expect(prov.topRatedState, RequestState.empty);
    });
    test('test: Every state initializes empty List<TvShow>\n', () {
      expect(prov.airingTodayTvShows, <TvShow>[]);
      expect(prov.popularTvShows, <TvShow>[]);
      expect(prov.topRatedTvShows, <TvShow>[]);
    });
    group('.fetchAiringTodayTvShows() test:', () {
      test('Loading data condition', () {
        when(mockGetAiringToday.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        prov.fetchAiringTodayTvShows();

        expect(prov.airingTodayState, RequestState.loading);
        expect(notifyCount, 1);
      });
      test('The condition when fetching data is successful', () async {
        when(mockGetAiringToday.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        await prov.fetchAiringTodayTvShows();

        expect(prov.airingTodayState, RequestState.loaded);
        expect(prov.airingTodayTvShows, [dummyTvShow]);
        expect(notifyCount, 2);
      });
      test('The condition when fetching data is fail\n', () async {
        when(mockGetAiringToday.execute()).thenAnswer(
          (_) async => const Left(ServerFailure(serverFailMsg)),
        );

        await prov.fetchAiringTodayTvShows();

        expect(prov.airingTodayState, RequestState.error);
        expect(prov.message, serverFailMsg);
        expect(notifyCount, 2);
      });
    });
    group('.fetchPopularTvShows() test:', () {
      test('Loading data condition', () {
        when(mockGetPopular.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        prov.fetchPopularTvShows();

        expect(prov.popularState, RequestState.loading);
        expect(notifyCount, 1);
      });
      test('The condition when fetching data is successful', () async {
        when(mockGetPopular.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        await prov.fetchPopularTvShows();

        expect(prov.popularState, RequestState.loaded);
        expect(prov.popularTvShows, [dummyTvShow]);
        expect(notifyCount, 2);
      });
      test('The condition when fetching data is fail\n', () async {
        when(mockGetPopular.execute()).thenAnswer(
          (_) async => const Left(ServerFailure(serverFailMsg)),
        );

        await prov.fetchPopularTvShows();

        expect(prov.popularState, RequestState.error);
        expect(prov.message, serverFailMsg);
        expect(notifyCount, 2);
      });
    });
    group('.fetchTopRatedTvShows() test:', () {
      test('Loading data condition', () {
        when(mockGetTopRated.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        prov.fetchTopRatedTvShows();

        expect(prov.topRatedState, RequestState.loading);
        expect(notifyCount, 1);
      });
      test('The condition when fetching data is successful', () async {
        when(mockGetTopRated.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        await prov.fetchTopRatedTvShows();

        expect(prov.topRatedState, RequestState.loaded);
        expect(prov.topRatedTvShows, [dummyTvShow]);
        expect(notifyCount, 2);
      });
      test('The condition when fetching data is fail\n', () async {
        when(mockGetTopRated.execute()).thenAnswer(
          (_) async => const Left(ServerFailure(serverFailMsg)),
        );

        await prov.fetchTopRatedTvShows();

        expect(prov.topRatedState, RequestState.error);
        expect(prov.message, serverFailMsg);
        expect(notifyCount, 2);
      });
    });
  });
}
