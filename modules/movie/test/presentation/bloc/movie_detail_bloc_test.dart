import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/mock_usecases.mocks.dart';

void main() {
  late MovieDetailBloc testBloc;
  late MockGetMovieDetail mockGetDetail;
  late MockGetMovieRecommendations mockGetRecomms;
  late MockGetWatchListStatus mockGetStatus;
  late MockSaveWatchlist mockSaveToDb;
  late MockRemoveWatchlist mockRemoveFromDb;

  setUp(() {
    mockGetDetail = MockGetMovieDetail();
    mockGetRecomms = MockGetMovieRecommendations();
    mockGetStatus = MockGetWatchListStatus();
    mockSaveToDb = MockSaveWatchlist();
    mockRemoveFromDb = MockRemoveWatchlist();
    testBloc = MovieDetailBloc(
      getMovieDetail: mockGetDetail,
      getMovieRecommendations: mockGetRecomms,
      saveWatchlist: mockSaveToDb,
      removeWatchlist: mockRemoveFromDb,
      getWatchListStatus: mockGetStatus,
    );
  });

  const dummyMsg = 'Success';
  const dummyFailMsg = 'Fail';
  const dummyId = 1;

  group('MovieDetailBloc', () {
    test('test: The BLoC State properties has been init.\n', () {
      expect(testBloc.state.blocState, RequestState.empty);
      expect(testBloc.state.movieDetail, null);
      expect(testBloc.state.recomms, []);
      expect(testBloc.state.blocStateMsg, '');
      expect(testBloc.state.watchlistMsg, '');
    });

    group('Event (OnFetchDetail) test:', () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Emits [state.blocState == RequestState.loaded] when OnFetchDetail is added.',
        build: () {
          when(mockGetDetail.execute(dummyId))
              .thenAnswer((_) async => const Right(dummyMovieDetail));
          when(mockGetRecomms.execute(dummyId))
              .thenAnswer((_) async => Right(dummyMovieList));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchDetail(dummyId)),
        verify: (_) => verify(mockGetDetail.execute(dummyId)),
        expect: () => [
          MovieDetailState.init().copyWith(
            blocState: RequestState.loading,
          ),
          MovieDetailState.init().copyWith(
            blocState: RequestState.loaded,
            movieDetail: dummyMovieDetail,
            recomms: dummyMovieList,
          ),
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
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
          MovieDetailState.init().copyWith(
            blocState: RequestState.loading,
          ),
          MovieDetailState.init().copyWith(
            blocState: RequestState.error,
            blocStateMsg: dummyFailMsg,
          ),
        ],
      );
    });

    group('Event (OnLoadDbStatus) test:', () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Emits [state.watchlistStatus == true] when OnLoadDbStatus is added.',
        build: () {
          when(mockGetStatus.execute(dummyId)).thenAnswer((_) async => true);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnLoadDbStatus(dummyId)),
        verify: (_) => verify(mockGetStatus.execute(dummyId)),
        expect: () => [
          MovieDetailState.init().copyWith(watchlistStatus: true),
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'Emits [state.watchlistStatus == false] when OnLoadDbStatus is added.\n',
        build: () {
          when(mockGetStatus.execute(dummyId)).thenAnswer((_) async => false);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnLoadDbStatus(dummyId)),
        verify: (_) => verify(mockGetStatus.execute(dummyId)),
        expect: () => [
          MovieDetailState.init().copyWith(watchlistStatus: false),
        ],
      );
    });

    group('Event (OnAddToDb) test:', () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        'emits [state.watchlistMsg == dummyMsg] when OnAddToDb is added.',
        build: () {
          when(mockSaveToDb.execute(dummyMovieDetail))
              .thenAnswer((_) async => const Right(dummyMsg));
          when(mockGetStatus.execute(dummyMovieDetail.id))
              .thenAnswer((_) async => true);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnAddToDb(dummyMovieDetail)),
        expect: () => [
          MovieDetailState.init().copyWith(
            watchlistMsg: dummyMsg,
            watchlistStatus: true,
          ),
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'emits [state.watchlistMsg == dummyFailMsg] when OnAddToDb is added.\n',
        build: () {
          when(mockSaveToDb.execute(dummyMovieDetail)).thenAnswer(
              (_) async => const Left(DatabaseFailure(dummyFailMsg)));
          when(mockGetStatus.execute(dummyMovieDetail.id))
              .thenAnswer((_) async => false);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnAddToDb(dummyMovieDetail)),
        expect: () => [
          MovieDetailState.init().copyWith(watchlistMsg: dummyFailMsg),
        ],
      );
    });

    group('Event (OnRemoveFromDb) test:', () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        'emits [state.watchlistMsg == dummyMsg] when OnRemoveFromDb is added.',
        build: () {
          when(mockRemoveFromDb.execute(dummyMovieDetail))
              .thenAnswer((_) async => const Right(dummyMsg));
          when(mockGetStatus.execute(dummyMovieDetail.id))
              .thenAnswer((_) async => false);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnRemoveFromDb(dummyMovieDetail)),
        expect: () => [
          MovieDetailState.init().copyWith(watchlistMsg: dummyMsg),
        ],
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'emits [state.watchlistMsg == dummyFailMsg] when OnRemoveFromDb is added.',
        build: () {
          when(mockRemoveFromDb.execute(dummyMovieDetail)).thenAnswer(
              (_) async => const Left(DatabaseFailure(dummyFailMsg)));
          when(mockGetStatus.execute(dummyMovieDetail.id))
              .thenAnswer((_) async => false);

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnRemoveFromDb(dummyMovieDetail)),
        expect: () => [
          MovieDetailState.init().copyWith(watchlistMsg: dummyFailMsg),
        ],
      );
    });
  });
}
