import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/provider/tv_show/tv_show_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_show/tv_show_dummy_obj.dart';
import '../../../helpers/tv_show_usecase_helper.mocks.dart';

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

  void _fetchDetailSuccessArrange(int id) {
    when(mockGetDetail.execute(id))
        .thenAnswer((_) async => Right(dummyTvShowDetail));
    when(mockGetRecomm.execute(id))
        .thenAnswer((_) async => Right([dummyTvShow]));
  }

  void _fetchDetailFailArrange(int id) {
    when(mockGetDetail.execute(id))
        .thenAnswer((_) async => Left(ServerFailure('Fail to fetch')));
    when(mockGetRecomm.execute(id))
        .thenAnswer((_) async => Left(ServerFailure('Fail to fetch')));
  }

  group('TvShowDetailNotifier', () {
    test(
      'test: Every properties initializes empty state (Except _tvShowDetail)\n',
      () {
        expect(prov.recommResults, <TvShow>[]);
        expect(prov.detailState, RequestState.Empty);
        expect(prov.recommState, RequestState.Empty);
        expect(prov.detailMsg, '');
        expect(prov.recommMsg, '');
        expect(prov.watchlistMsg, '');
      },
    );

    group('.fetchDetail() test:', () {
      test('Loading data condition', () {
        _fetchDetailSuccessArrange(1);

        prov.fetchDetail(1);

        expect(prov.detailState, RequestState.Loading);
        expect(notifyCount, 1);
      });
      test('The condition when fetching data is successful', () async {
        _fetchDetailSuccessArrange(1);

        await prov.fetchDetail(1);

        expect(prov.detailResult, dummyTvShowDetail);
        expect(prov.recommResults, [dummyTvShow]);
        expect(prov.detailState, RequestState.Loaded);
        expect(prov.recommState, RequestState.Loaded);
        expect(notifyCount, 3);
      });
      test('The condition when fetching data is fail\n', () async {
        _fetchDetailFailArrange(1);

        await prov.fetchDetail(1);

        expect(prov.detailMsg, 'Fail to fetch');
        expect(prov.recommMsg, '');
        expect(prov.detailState, RequestState.Error);
        expect(prov.recommState, RequestState.Empty);
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
            .thenAnswer((_) async => Right('Saved'));
        when(mockGetWatchlistStatus.execute(dummyTvShowDetail.id))
            .thenAnswer((_) async => true);

        await prov.addToWatchlist(dummyTvShowDetail);

        expect(prov.watchlistMsg, 'Saved');
        expect(prov.isWatchlisted, true);
        expect(notifyCount, 1);
      });
      test('The condition when add Tv Show to Watchlist is Fail\n', () async {
        when(mockSaveToWatchlist.execute(dummyTvShowDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Fail to save')));
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
            .thenAnswer((_) async => Right('Removed'));
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
            .thenAnswer((_) async => Left(DatabaseFailure('Fail to remove')));
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
