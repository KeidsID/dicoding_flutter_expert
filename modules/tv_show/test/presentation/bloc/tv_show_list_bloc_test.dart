import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/presentation/bloc/tv_show_list/tv_show_list_bloc.dart';

import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/tv_show_usecase_helper.mocks.dart';

void main() {
  late TvShowListBloc testBloc;
  late MockGetAiringTodayTvShows mockGetAiring;
  late MockGetPopularTvShows mockGetPop;
  late MockGetTopRatedTvShows mockGetTop;

  setUp(() {
    mockGetAiring = MockGetAiringTodayTvShows();
    mockGetPop = MockGetPopularTvShows();
    mockGetTop = MockGetTopRatedTvShows();
    testBloc = TvShowListBloc(
      getAiringTodayTvShows: mockGetAiring,
      getPopularTvShows: mockGetPop,
      getTopRatedTvShows: mockGetTop,
    );
  });

  const dummyMsg = 'Fail';

  group('OnFetchAiringToday event test:', () {
    blocTest<TvShowListBloc, TvShowListState>(
      'emits [atState -> loading, atState -> loaded] when OnFetchAiringToday is added.',
      build: () {
        when(mockGetAiring.execute())
            .thenAnswer((_) async => Right(dummyTvShowList));

        return testBloc;
      },
      act: (bloc) => bloc.add(const OnFetchAiringToday()),
      verify: (_) => verify(mockGetAiring.execute()),
      expect: () => <TvShowListState>[
        TvShowListState.init().copyWith(atState: RequestState.loading),
        TvShowListState.init().copyWith(
          atState: RequestState.loaded,
          atResults: dummyTvShowList,
        ),
      ],
    );

    blocTest<TvShowListBloc, TvShowListState>(
      'emits [atState -> loading, atState -> error] when OnFetchAiringToday is added.',
      build: () {
        when(mockGetAiring.execute())
            .thenAnswer((_) async => const Left(ConnectionFailure(dummyMsg)));

        return testBloc;
      },
      act: (bloc) => bloc.add(const OnFetchAiringToday()),
      verify: (_) => verify(mockGetAiring.execute()),
      expect: () => <TvShowListState>[
        TvShowListState.init().copyWith(atState: RequestState.loading),
        TvShowListState.init().copyWith(
          atState: RequestState.error,
          msg: dummyMsg,
        ),
      ],
    );
  });

  group('OnFetchPopular event test:', () {
    blocTest<TvShowListBloc, TvShowListState>(
      'emits [popState -> loading, popState -> loaded] when OnFetchPopular is added.',
      build: () {
        when(mockGetPop.execute())
            .thenAnswer((_) async => Right(dummyTvShowList));

        return testBloc;
      },
      act: (bloc) => bloc.add(const OnFetchPopular()),
      verify: (_) => verify(mockGetPop.execute()),
      expect: () => <TvShowListState>[
        TvShowListState.init().copyWith(popState: RequestState.loading),
        TvShowListState.init().copyWith(
          popState: RequestState.loaded,
          popResults: dummyTvShowList,
        ),
      ],
    );

    blocTest<TvShowListBloc, TvShowListState>(
      'emits [popState -> loading, popState -> error] when OnFetchPopular is added.',
      build: () {
        when(mockGetPop.execute())
            .thenAnswer((_) async => const Left(ConnectionFailure(dummyMsg)));

        return testBloc;
      },
      act: (bloc) => bloc.add(const OnFetchPopular()),
      verify: (_) => verify(mockGetPop.execute()),
      expect: () => <TvShowListState>[
        TvShowListState.init().copyWith(popState: RequestState.loading),
        TvShowListState.init().copyWith(
          popState: RequestState.error,
          msg: dummyMsg,
        ),
      ],
    );
  });

  group('OnFetchTopRated event test:', () {
    blocTest<TvShowListBloc, TvShowListState>(
      'emits [trState -> loading, trState -> loaded] when OnFetchTopRated is added.',
      build: () {
        when(mockGetTop.execute())
            .thenAnswer((_) async => Right(dummyTvShowList));

        return testBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTopRated()),
      verify: (_) => verify(mockGetTop.execute()),
      expect: () => <TvShowListState>[
        TvShowListState.init().copyWith(trState: RequestState.loading),
        TvShowListState.init().copyWith(
          trState: RequestState.loaded,
          trResults: dummyTvShowList,
        ),
      ],
    );

    blocTest<TvShowListBloc, TvShowListState>(
      'emits [trState -> loading, trState -> error] when OnFetchTopRated is added.',
      build: () {
        when(mockGetTop.execute())
            .thenAnswer((_) async => const Left(ConnectionFailure(dummyMsg)));

        return testBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTopRated()),
      verify: (_) => verify(mockGetTop.execute()),
      expect: () => <TvShowListState>[
        TvShowListState.init().copyWith(trState: RequestState.loading),
        TvShowListState.init().copyWith(
          trState: RequestState.error,
          msg: dummyMsg,
        ),
      ],
    );
  });
}
