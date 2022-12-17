import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/presentation/provider/tv_show_detail_notifier.dart';

import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/tv_show_usecase_helper.mocks.dart';

void main() {
  late TvShowDetailNotifier prov;
  late int notifyCount;
  late MockGetTvShowDetail mockGetDetail;
  late MockGetTvShowRecommendations mockGetRecomm;
  late MockGetTvShowWatchlistStatus mockGetWatchlistStatus;
  late MockSaveTvShowToWatchlist mockSaveToWatchlist;
  late MockRemoveTvShowFromWatchlist mockRemoveFromWatchlist;

  setUp(() {
    notifyCount = 0;
    mockGetDetail = MockGetTvShowDetail();
    mockGetRecomm = MockGetTvShowRecommendations();
    mockGetWatchlistStatus = MockGetTvShowWatchlistStatus();
    mockSaveToWatchlist = MockSaveTvShowToWatchlist();
    mockRemoveFromWatchlist = MockRemoveTvShowFromWatchlist();
    prov = TvShowDetailNotifier(
      getTvShowDetail: mockGetDetail,
      getTvShowRecommendations: mockGetRecomm,
      getWatchlistStatus: mockGetWatchlistStatus,
      saveToWatchliist: mockSaveToWatchlist,
      removeFromWatchlist: mockRemoveFromWatchlist,
    )..addListener(() => ++notifyCount);
  });

  void fetchDetailSuccessArrange(int id) {
    when(mockGetDetail.execute(id))
        .thenAnswer((_) async => const Right(dummyTvShowDetail));
    when(mockGetRecomm.execute(id))
        .thenAnswer((_) async => Right([dummyTvShow]));
  }

  void fetchDetailFailArrange(int id) {
    when(mockGetDetail.execute(id))
        .thenAnswer((_) async => const Left(ServerFailure('Fail to fetch')));
    when(mockGetRecomm.execute(id))
        .thenAnswer((_) async => const Left(ServerFailure('Fail to fetch')));
  }

  group('TvShowDetailNotifier', () {
    test(
      'test: Every properties initializes empty state (Except _tvShowDetail)\n',
      () {
        expect(prov.recommResults, <TvShow>[]);
        expect(prov.detailState, RequestState.empty);
        expect(prov.recommState, RequestState.empty);
        expect(prov.detailMsg, '');
        expect(prov.recommMsg, '');
        expect(prov.watchlistMsg, '');
      },
    );

    group('.fetchDetail() test:', () {
      test('Loading data condition', () {
        fetchDetailSuccessArrange(1);

        prov.fetchDetail(1);

        expect(prov.detailState, RequestState.loading);
        expect(notifyCount, 1);
      });
      test('The condition when fetching data is successful', () async {
        fetchDetailSuccessArrange(1);

        await prov.fetchDetail(1);

        expect(prov.detailResult, dummyTvShowDetail);
        expect(prov.recommResults, [dummyTvShow]);
        expect(prov.detailState, RequestState.loaded);
        expect(prov.recommState, RequestState.loaded);
        expect(notifyCount, 3);
      });
      test('The condition when fetching data is fail\n', () async {
        fetchDetailFailArrange(1);

        await prov.fetchDetail(1);

        expect(prov.detailMsg, 'Fail to fetch');
        expect(prov.recommMsg, '');
        expect(prov.detailState, RequestState.error);
        expect(prov.recommState, RequestState.empty);
        expect(notifyCount, 2);
      });
    });
    group('.loadWatchlistStatus test:', () {
      test('The condition when Tv Show input is Watchlisted', () async {
        when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);

        await prov.loadWatchlistStatus(1);

        expect(prov.isWatchlisted, true);
        expect(notifyCount, 1);
      });
      test('The condition when Tv Show input is NOT Watchlisted\n', () async {
        when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => false);

        await prov.loadWatchlistStatus(1);

        expect(prov.isWatchlisted, false);
        expect(notifyCount, 1);
      });
    });
    group('.addToWatchlist() test:', () {
      test('The condition when add Tv Show to Watchlist is success', () async {
        when(mockSaveToWatchlist.execute(dummyTvShowDetail))
            .thenAnswer((_) async => const Right('Saved'));
        when(mockGetWatchlistStatus.execute(dummyTvShowDetail.id))
            .thenAnswer((_) async => true);

        await prov.addToWatchlist(dummyTvShowDetail);

        expect(prov.watchlistMsg, 'Saved');
        expect(prov.isWatchlisted, true);
        expect(notifyCount, 1);
      });
      test('The condition when add Tv Show to Watchlist is Fail\n', () async {
        when(mockSaveToWatchlist.execute(dummyTvShowDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Fail to save')));
        when(mockGetWatchlistStatus.execute(dummyTvShowDetail.id))
            .thenAnswer((_) async => false);

        await prov.addToWatchlist(dummyTvShowDetail);

        expect(prov.watchlistMsg, 'Fail to save');
        expect(prov.isWatchlisted, false);
        expect(notifyCount, 1);
      });
    });
    group('.deleteFromWatchlist() test:', () {
      test('The condition when remove Tv Show from Watchlist is success',
          () async {
        when(mockRemoveFromWatchlist.execute(dummyTvShowDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatus.execute(dummyTvShowDetail.id))
            .thenAnswer((_) async => false);

        await prov.deleteFromWatchlist(dummyTvShowDetail);

        expect(prov.watchlistMsg, 'Removed');
        expect(prov.isWatchlisted, false);
        expect(notifyCount, 1);
      });
      test('The condition when remove Tv Show from Watchlist is Fail\n',
          () async {
        when(mockRemoveFromWatchlist.execute(dummyTvShowDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Fail to remove')));
        when(mockGetWatchlistStatus.execute(dummyTvShowDetail.id))
            .thenAnswer((_) async => true);

        await prov.deleteFromWatchlist(dummyTvShowDetail);

        expect(prov.watchlistMsg, 'Fail to remove');
        expect(prov.isWatchlisted, true);
        expect(notifyCount, 1);
      });
    });
  });
}
