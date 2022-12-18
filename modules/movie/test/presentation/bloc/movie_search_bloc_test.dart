import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';

import 'package:movie/presentation/bloc/movie_search/movie_search_bloc.dart';
import '../../helper/mock_usecases.mocks.dart';

void main() {
  late MovieSearchBloc testBloc;
  late MockSearchMovies mockUsecase;

  setUp(() {
    mockUsecase = MockSearchMovies();
    testBloc = MovieSearchBloc(mockUsecase);
  });

  test('initial state should be empty', () {
    expect(testBloc.state, const InitState());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return testBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    verify: (_) => verify(mockUsecase.execute(tQuery)),
    expect: () => [
      const SearchLoading(),
      SearchLoaded(tMovieList),
    ],
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockUsecase.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return testBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    verify: (_) => verify(mockUsecase.execute(tQuery)),
    expect: () => [
      const SearchLoading(),
      const SearchError('Server Failure'),
    ],
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'emits [StateInit] when OnDidChangeDep is added.',
    build: () => testBloc,
    act: (bloc) => bloc.add(const OnDidChangeDep()),
    expect: () => const [InitState()],
  );
  blocTest<MovieSearchBloc, MovieSearchState>(
    'emits [StateInit] when OnEmptyQuery is added.',
    build: () => testBloc,
    act: (bloc) => bloc.add(const OnEmptyQuery()),
    wait: const Duration(milliseconds: 500),
    expect: () => const [InitState()],
  );
}
