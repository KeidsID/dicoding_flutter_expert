import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';

import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/tv_show_usecase_helper.mocks.dart';

void main() {
  late TvShowDetailBloc testBloc;
  late MockGetTvShowDetail mockGetDetail;
  late MockGetTvShowRecommendations mockGetRecomms;
  late MockGetTvShowWatchlistStatus mockGetStatus;
  late MockSaveTvShowToWatchlist mockSaveToDb;
  late MockRemoveTvShowFromWatchlist mockRemoveFromDb;

  setUp(() {
    mockGetDetail = MockGetTvShowDetail();
    mockGetRecomms = MockGetTvShowRecommendations();
    mockGetStatus = MockGetTvShowWatchlistStatus();
    mockSaveToDb = MockSaveTvShowToWatchlist();
    mockRemoveFromDb = MockRemoveTvShowFromWatchlist();
    testBloc = TvShowDetailBloc(
      getTvShowDetail: mockGetDetail,
      getTvShowRecommendations: mockGetRecomms,
      getTvShowWatchlistStatus: mockGetStatus,
      saveTvShowToWatchlist: mockSaveToDb,
      removeTvShowFromWatchlist: mockRemoveFromDb,
    );
  });

  const dummyMsg = 'Success';
  const dummyFailMsg = 'Fail';
  const dummyId = 1;

  group('TvShowDetailBloc', () {
    test('test: The BLoC State properties has been init.\n', () {
      expect(testBloc.state.blocState, RequestState.empty);
      expect(testBloc.state.tvShowDetail, null);
      expect(testBloc.state.recomms, []);
      expect(testBloc.state.blocStateMsg, '');
      expect(testBloc.state.watchlistMsg, '');
    });

    group('Event (OnFetchDetail) test:', () {
      blocTest<TvShowDetailBloc, TvShowDetailState>(
        'Emits [state.blocState == RequestState.loaded] when OnFetchDetail is added.',
        build: () {
          when(mockGetDetail.execute(dummyId))
              .thenAnswer((_) async => const Right(dummyTvShowDetail));
          when(mockGetRecomms.execute(dummyId))
              .thenAnswer((_) async => Right(dummyTvShowList));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchDetail(dummyId)),
        verify: (_) => verify(mockGetDetail.execute(dummyId)),
        expect: () => [
          TvShowDetailState.init().copyWith(
            blocState: RequestState.loading,
          ),
          TvShowDetailState.init().copyWith(
            blocState: RequestState.loaded,
            tvShowDetail: dummyTvShowDetail,
            recomms: dummyTvShowList,
          ),
        ],
      );

      blocTest<TvShowDetailBloc, TvShowDetailState>(
        'Emits [state.blocState == RequestState.error] when OnFetchDetail is added.\n',
        build: () {
          when(mockGetDetail.execute(dummyId))
              .thenAnswer((_) async => const Left(ServerFailure(dummyFailMsg)));
          when(mockGetRecomms.execute(dummyId))
              .thenAnswer((_) async => const Left(ServerFailure(dummyFailMsg)));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchDetail(dummyId)),
        verify: (_) => verify(mockGetDetail.execute(dummyId)),
        expect: () => [
          TvShowDetailState.init().copyWith(
            blocState: RequestState.loading,
          ),
          TvShowDetailState.init().copyWith(
            blocState: RequestState.error,
            blocStateMsg: dummyFailMsg,
          ),
        ],
      );
    });

    group('Event (OnLoadDbStatus) test:', () {
      blocTest<TvShowDetailBloc, TvShowDetailState>(
        'Emits [state.watchlistStatus == true] when OnLoadDbStatus is added.',
        build: () {
          when(mockGetStatus.execute(dummyId)).thenAnswer((_) async => true);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnLoadDbStatus(dummyId)),
        verify: (_) => verify(mockGetStatus.execute(dummyId)),
        expect: () => [
          TvShowDetailState.init().copyWith(watchlistStatus: true),
        ],
      );

      blocTest<TvShowDetailBloc, TvShowDetailState>(
        'Emits [state.watchlistStatus == false] when OnLoadDbStatus is added.\n',
        build: () {
          when(mockGetStatus.execute(dummyId)).thenAnswer((_) async => false);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnLoadDbStatus(dummyId)),
        verify: (_) => verify(mockGetStatus.execute(dummyId)),
        expect: () => [
          TvShowDetailState.init().copyWith(watchlistStatus: false),
        ],
      );
    });

    group('Event (OnAddToDb) test:', () {
      blocTest<TvShowDetailBloc, TvShowDetailState>(
        'emits [state.watchlistMsg == dummyMsg] when OnAddToDb is added.',
        build: () {
          when(mockSaveToDb.execute(dummyTvShowDetail))
              .thenAnswer((_) async => const Right(dummyMsg));
          when(mockGetStatus.execute(dummyTvShowDetail.id))
              .thenAnswer((_) async => true);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnAddToDb(dummyTvShowDetail)),
        expect: () => [
          TvShowDetailState.init().copyWith(
            watchlistMsg: dummyMsg,
            watchlistStatus: true,
          ),
        ],
      );

      blocTest<TvShowDetailBloc, TvShowDetailState>(
        'emits [state.watchlistMsg == dummyFailMsg] when OnAddToDb is added.\n',
        build: () {
          when(mockSaveToDb.execute(dummyTvShowDetail)).thenAnswer(
              (_) async => const Left(DatabaseFailure(dummyFailMsg)));
          when(mockGetStatus.execute(dummyTvShowDetail.id))
              .thenAnswer((_) async => false);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnAddToDb(dummyTvShowDetail)),
        expect: () => [
          TvShowDetailState.init().copyWith(watchlistMsg: dummyFailMsg),
        ],
      );
    });

    group('Event (OnRemoveFromDb) test:', () {
      blocTest<TvShowDetailBloc, TvShowDetailState>(
        'emits [state.watchlistMsg == dummyMsg] when OnRemoveFromDb is added.',
        build: () {
          when(mockRemoveFromDb.execute(dummyTvShowDetail))
              .thenAnswer((_) async => const Right(dummyMsg));
          when(mockGetStatus.execute(dummyTvShowDetail.id))
              .thenAnswer((_) async => false);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnRemoveFromDb(dummyTvShowDetail)),
        expect: () => [
          TvShowDetailState.init().copyWith(watchlistMsg: dummyMsg),
        ],
      );

      blocTest<TvShowDetailBloc, TvShowDetailState>(
        'emits [state.watchlistMsg == dummyFailMsg] when OnRemoveFromDb is added.',
        build: () {
          when(mockRemoveFromDb.execute(dummyTvShowDetail)).thenAnswer(
              (_) async => const Left(DatabaseFailure(dummyFailMsg)));
          when(mockGetStatus.execute(dummyTvShowDetail.id))
              .thenAnswer((_) async => false);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnRemoveFromDb(dummyTvShowDetail)),
        expect: () => [
          TvShowDetailState.init().copyWith(watchlistMsg: dummyFailMsg),
        ],
      );
    });
  });
}
