import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/mock_usecases.mocks.dart';

void main() {
  late WatchlistMovieBloc testBloc;
  late MockGetWatchlistMovies mockUsecase;

  setUp(() {
    mockUsecase = MockGetWatchlistMovies();
    testBloc = WatchlistMovieBloc(mockUsecase);
  });

  const dummyMsg = 'Fail';

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'emits [Loading, HasData] when OnFetchWatchlistMovies is added.',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Right([dummyWatchlistMovie]));

      return testBloc;
    },
    act: (bloc) => bloc.add(const OnFetchWatchlistMovies()),
    expect: () => [
      const Loading(),
      HasData([dummyWatchlistMovie]),
    ],
  );
  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'emits [Loading, Error] when OnFetchWatchlistMovies is added.',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => const Left(DatabaseFailure(dummyMsg)));

      return testBloc;
    },
    act: (bloc) => bloc.add(const OnFetchWatchlistMovies()),
    expect: () => const [
      Loading(),
      Error(dummyMsg),
    ],
  );
}
