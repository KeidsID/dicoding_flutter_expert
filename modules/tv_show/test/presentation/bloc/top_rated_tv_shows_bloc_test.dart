import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/presentation/bloc/top_rated_tv_shows/top_rated_tv_shows_bloc.dart';

import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/tv_show_usecase_helper.mocks.dart';

void main() {
  late TopRatedTvShowsBloc testBloc;
  late MockGetTopRatedTvShows mockUsecase;

  setUp(() {
    mockUsecase = MockGetTopRatedTvShows();
    testBloc = TopRatedTvShowsBloc(mockUsecase);
  });

  final dummyTvShowList = [dummyTvShow];
  const dummyMsg = 'Fail';

  blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState>(
    'emits [Loading, HasData] when OnFetchTvShows is added.',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Right(dummyTvShowList));

      return testBloc;
    },
    act: (bloc) => bloc.add(const OnFetchTvShows()),
    expect: () => [
      const Loading(),
      HasData(dummyTvShowList),
    ],
  );

  blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState>(
    'emits [Loading, Error] when OnFetchTvShows is added.',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => const Left(ConnectionFailure(dummyMsg)));

      return testBloc;
    },
    act: (bloc) => bloc.add(const OnFetchTvShows()),
    expect: () => [
      const Loading(),
      const Error(dummyMsg),
    ],
  );
}
