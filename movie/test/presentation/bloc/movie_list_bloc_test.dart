import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/mock_usecases.mocks.dart';

void main() {
  late MovieListBloc testBloc;
  late MockGetNowPlayingMovies mockGetNpMovies;
  late MockGetPopularMovies mockGetPopMovies;
  late MockGetTopRatedMovies mockGetTrMovies;

  setUp(() {
    mockGetNpMovies = MockGetNowPlayingMovies();
    mockGetPopMovies = MockGetPopularMovies();
    mockGetTrMovies = MockGetTopRatedMovies();
    testBloc = MovieListBloc(
      getNowPlayingMovies: mockGetNpMovies,
      getPopularMovies: mockGetPopMovies,
      getTopRatedMovies: mockGetTrMovies,
    );
  });

  const serverFailMsg = 'Server Failure';

  group('MovieListBloc', () {
    test('test: The state properties has been init\n', () {
      expect(testBloc.state.npState, RequestState.empty);
      expect(testBloc.state.popState, RequestState.empty);
      expect(testBloc.state.trState, RequestState.empty);
      expect(testBloc.state.npResults, <Movie>[]);
      expect(testBloc.state.popResults, <Movie>[]);
      expect(testBloc.state.trResults, <Movie>[]);
      expect(testBloc.state.msg, '');
    });

    group('event (OnFetchingNowPlayingMovies) test:', () {
      blocTest<MovieListBloc, MovieListState>(
        'On loaded npState conditions',
        build: () {
          when(mockGetNpMovies.execute())
              .thenAnswer((_) async => Right(dummyMovieList));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchingNowPlayingMovies()),
        verify: (_) => verify(mockGetNpMovies.execute()),
        expect: () => [
          MovieListState.init().copyWith(npState: RequestState.loading),
          MovieListState.init().copyWith(
            npState: RequestState.loaded,
            npResults: dummyMovieList,
          ),
        ],
      );

      blocTest<MovieListBloc, MovieListState>(
        'On error npState conditions\n',
        build: () {
          when(mockGetNpMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure(serverFailMsg)));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchingNowPlayingMovies()),
        verify: (_) => verify(mockGetNpMovies.execute()),
        expect: () => [
          MovieListState.init().copyWith(npState: RequestState.loading),
          MovieListState.init().copyWith(
            npState: RequestState.error,
            msg: serverFailMsg,
          ),
        ],
      );
    });

    group('event (OnFetchingPopularMovies) test:', () {
      blocTest<MovieListBloc, MovieListState>(
        'On loaded popState conditions',
        build: () {
          when(mockGetPopMovies.execute())
              .thenAnswer((_) async => Right(dummyMovieList));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchingPopularMovies()),
        verify: (_) => verify(mockGetPopMovies.execute()),
        expect: () => [
          MovieListState.init().copyWith(popState: RequestState.loading),
          MovieListState.init().copyWith(
            popState: RequestState.loaded,
            popResults: dummyMovieList,
          ),
        ],
      );

      blocTest<MovieListBloc, MovieListState>(
        'On error popState conditions\n',
        build: () {
          when(mockGetPopMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure(serverFailMsg)));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchingPopularMovies()),
        verify: (_) => verify(mockGetPopMovies.execute()),
        expect: () => [
          MovieListState.init().copyWith(popState: RequestState.loading),
          MovieListState.init().copyWith(
            popState: RequestState.error,
            msg: serverFailMsg,
          ),
        ],
      );
    });

    group('event (OnFetchingTopRatedMovies) test:', () {
      blocTest<MovieListBloc, MovieListState>(
        'On loaded trState conditions',
        build: () {
          when(mockGetTrMovies.execute())
              .thenAnswer((_) async => Right(dummyMovieList));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchingTopRatedMovies()),
        verify: (_) => verify(mockGetTrMovies.execute()),
        expect: () => [
          MovieListState.init().copyWith(trState: RequestState.loading),
          MovieListState.init().copyWith(
            trState: RequestState.loaded,
            trResults: dummyMovieList,
          ),
        ],
      );

      blocTest<MovieListBloc, MovieListState>(
        'On error trState conditions\n',
        build: () {
          when(mockGetTrMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure(serverFailMsg)));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchingTopRatedMovies()),
        verify: (_) => verify(mockGetTrMovies.execute()),
        expect: () => [
          MovieListState.init().copyWith(trState: RequestState.loading),
          MovieListState.init().copyWith(
            trState: RequestState.error,
            msg: serverFailMsg,
          ),
        ],
      );
    });
  });
}
