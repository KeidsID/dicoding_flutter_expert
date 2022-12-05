import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/provider/tv_show/tv_show_list_notifier.dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_show/tv_show_dummy_obj.dart';
import '../../../helpers/tv_show_usecase_helper.mocks.dart';

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
      expect(prov.airingTodayState, RequestState.Empty);
      expect(prov.popularState, RequestState.Empty);
      expect(prov.topRatedState, RequestState.Empty);
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

        expect(prov.airingTodayState, RequestState.Loading);
        expect(notifyCount, 1);
      });
      test('The condition when fetching data is successful', () async {
        when(mockGetAiringToday.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        await prov.fetchAiringTodayTvShows();

        expect(prov.airingTodayState, RequestState.Loaded);
        expect(prov.airingTodayTvShows, [dummyTvShow]);
        expect(notifyCount, 2);
      });
      test('The condition when fetching data is fail\n', () async {
        when(mockGetAiringToday.execute()).thenAnswer(
          (_) async => Left(ServerFailure(serverFailMsg)),
        );

        await prov.fetchAiringTodayTvShows();

        expect(prov.airingTodayState, RequestState.Error);
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

        expect(prov.popularState, RequestState.Loading);
        expect(notifyCount, 1);
      });
      test('The condition when fetching data is successful', () async {
        when(mockGetPopular.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        await prov.fetchPopularTvShows();

        expect(prov.popularState, RequestState.Loaded);
        expect(prov.popularTvShows, [dummyTvShow]);
        expect(notifyCount, 2);
      });
      test('The condition when fetching data is fail\n', () async {
        when(mockGetPopular.execute()).thenAnswer(
          (_) async => Left(ServerFailure(serverFailMsg)),
        );

        await prov.fetchPopularTvShows();

        expect(prov.popularState, RequestState.Error);
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

        expect(prov.topRatedState, RequestState.Loading);
        expect(notifyCount, 1);
      });
      test('The condition when fetching data is successful', () async {
        when(mockGetTopRated.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        await prov.fetchTopRatedTvShows();

        expect(prov.topRatedState, RequestState.Loaded);
        expect(prov.topRatedTvShows, [dummyTvShow]);
        expect(notifyCount, 2);
      });
      test('The condition when fetching data is fail\n', () async {
        when(mockGetTopRated.execute()).thenAnswer(
          (_) async => Left(ServerFailure(serverFailMsg)),
        );

        await prov.fetchTopRatedTvShows();

        expect(prov.topRatedState, RequestState.Error);
        expect(prov.message, serverFailMsg);
        expect(notifyCount, 2);
      });
    });
  });
}
