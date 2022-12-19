import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/presentation/bloc/watchlist_tv_show/watchlist_tv_show_bloc.dart';

import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/tv_show_usecase_helper.mocks.dart';

void main() {
  late WatchlistTvShowBloc testBloc;
  late MockGetWatchlistTvShows mockUsecase;

  setUp(() {
    mockUsecase = MockGetWatchlistTvShows();
    testBloc = WatchlistTvShowBloc(mockUsecase);
  });

  const dummyMsg = 'Fail';

  blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
    'emits [Loading, HasData] when OnFetchWatchlistTvShows is added.',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Right(dummyTvShowList));

      return testBloc;
    },
    act: (bloc) => bloc.add(const OnFetchWatchlistTvShows()),
    expect: () => [
      const Loading(),
      HasData(dummyTvShowList),
    ],
  );

  blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
    'emits [Loading, Error] when OnFetchWatchlistTvShows is added.',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => const Left(ConnectionFailure(dummyMsg)));

      return testBloc;
    },
    act: (bloc) => bloc.add(const OnFetchWatchlistTvShows()),
    expect: () => [
      const Loading(),
      const Error(dummyMsg),
    ],
  );
}
