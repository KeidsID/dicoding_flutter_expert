import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/mock_usecases.mocks.dart';

void main() {
  late PopularMoviesBloc testBloc;
  late MockGetPopularMovies mockUsecase;

  setUp(() {
    mockUsecase = MockGetPopularMovies();
    testBloc = PopularMoviesBloc(mockUsecase);
  });

  const serverFailMsg = 'Server Fail';

  group('PopularMoviesBloc', () {
    test('test: The BLoC State properties has been init\n', () {
      expect(testBloc.state.state, RequestState.empty);
      expect(testBloc.state.results, []);
      expect(testBloc.state.msg, '');
    });

    group('Event test:', () {
      blocTest<PopularMoviesBloc, PopularMoviesState>(
        'On loaded conditions',
        build: () {
          when(mockUsecase.execute())
              .thenAnswer((_) async => Right(dummyMovieList));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchingPopularMovies()),
        verify: (bloc) => verify(mockUsecase.execute()),
        expect: () => [
          PopularMoviesState.init().copyWith(state: RequestState.loading),
          PopularMoviesState.init().copyWith(
            state: RequestState.loaded,
            results: dummyMovieList,
          ),
        ],
      );
      blocTest<PopularMoviesBloc, PopularMoviesState>(
        'On error conditions\n',
        build: () {
          when(mockUsecase.execute()).thenAnswer(
              (_) async => const Left(ServerFailure(serverFailMsg)));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchingPopularMovies()),
        verify: (bloc) => verify(mockUsecase.execute()),
        expect: () => [
          PopularMoviesState.init().copyWith(state: RequestState.loading),
          PopularMoviesState.init().copyWith(
            state: RequestState.error,
            msg: serverFailMsg,
          ),
        ],
      );
    });
  });
}
