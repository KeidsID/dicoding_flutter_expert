import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:movie/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/mock_usecases.mocks.dart';

void main() {
  late TopRatedMoviesBloc testBloc;
  late MockGetTopRatedMovies mockUsecase;

  setUp(() {
    mockUsecase = MockGetTopRatedMovies();
    testBloc = TopRatedMoviesBloc(mockUsecase);
  });

  const serverFailMsg = 'Server Fail';

  group('TopRatedMoviesBloc', () {
    test('test: The BLoC State properties has been init\n', () {
      expect(testBloc.state.state, RequestState.empty);
      expect(testBloc.state.results, []);
      expect(testBloc.state.msg, '');
    });

    group('Event test:', () {
      blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
        'On loaded conditions',
        build: () {
          when(mockUsecase.execute())
              .thenAnswer((_) async => Right(dummyMovieList));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchingTopRatedMovies()),
        verify: (bloc) => verify(mockUsecase.execute()),
        expect: () => [
          TopRatedMoviesState.init().copyWith(state: RequestState.loading),
          TopRatedMoviesState.init().copyWith(
            state: RequestState.loaded,
            results: dummyMovieList,
          ),
        ],
      );
      blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
        'On error conditions\n',
        build: () {
          when(mockUsecase.execute()).thenAnswer(
              (_) async => const Left(ServerFailure(serverFailMsg)));

          return testBloc;
        },
        act: (bloc) => bloc.add(const OnFetchingTopRatedMovies()),
        verify: (bloc) => verify(mockUsecase.execute()),
        expect: () => [
          TopRatedMoviesState.init().copyWith(state: RequestState.loading),
          TopRatedMoviesState.init().copyWith(
            state: RequestState.error,
            msg: serverFailMsg,
          ),
        ],
      );
    });
  });
}
