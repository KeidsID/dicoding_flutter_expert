import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/presentation/bloc/tv_show_search/tv_show_search_bloc.dart';

import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/tv_show_usecase_helper.mocks.dart';

void main() {
  late TvShowSearchBloc testBloc;
  late MockSearchTvShows mockUsecase;

  setUp(() {
    mockUsecase = MockSearchTvShows();
    testBloc = TvShowSearchBloc(mockUsecase);
  });

  const dummyQuery = 'Lmao';
  const dummyMsg = 'Fail';
  final dummyTvShowList = [dummyTvShow];

  blocTest<TvShowSearchBloc, TvShowSearchState>(
    'emits [Loading, HasData] when OnQueryChanged is added.',
    build: () {
      when(mockUsecase.execute(dummyQuery))
          .thenAnswer((_) async => Right(dummyTvShowList));

      return testBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(dummyQuery)),
    verify: (_) => verify(mockUsecase.execute(dummyQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvShowSearchState>[
      const Loading(),
      HasData(dummyTvShowList),
    ],
  );

  blocTest<TvShowSearchBloc, TvShowSearchState>(
    'emits [Loading, Error] when OnQueryChanged is added.',
    build: () {
      when(mockUsecase.execute(dummyQuery))
          .thenAnswer((_) async => const Left(ConnectionFailure(dummyMsg)));

      return testBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(dummyQuery)),
    verify: (_) => verify(mockUsecase.execute(dummyQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => const <TvShowSearchState>[
      Loading(),
      Error(dummyMsg),
    ],
  );

  blocTest<TvShowSearchBloc, TvShowSearchState>(
    'emits [InitState] when OnDidChangeDep is added.',
    build: () => testBloc,
    act: (bloc) => bloc.add(const OnDidChangeDep()),
    expect: () => const <TvShowSearchState>[InitState()],
  );

  blocTest<TvShowSearchBloc, TvShowSearchState>(
    'emits [InitState] when OnEmptyQuery is added.',
    build: () => testBloc,
    act: (bloc) => bloc.add(const OnEmptyQuery()),
    wait: const Duration(milliseconds: 500),
    expect: () => const <TvShowSearchState>[InitState()],
  );
}
