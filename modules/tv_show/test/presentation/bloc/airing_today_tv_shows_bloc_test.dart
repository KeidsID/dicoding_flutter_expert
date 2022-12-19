import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/presentation/bloc/airing_today_tv_shows/airing_today_tv_shows_bloc.dart';

import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/tv_show_usecase_helper.mocks.dart';

void main() {
  late AiringTodayTvShowsBloc testBloc;
  late MockGetAiringTodayTvShows mockUsecase;

  setUp(() {
    mockUsecase = MockGetAiringTodayTvShows();
    testBloc = AiringTodayTvShowsBloc(mockUsecase);
  });

  const dummyMsg = 'Fail';

  blocTest<AiringTodayTvShowsBloc, AiringTodayTvShowsState>(
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

  blocTest<AiringTodayTvShowsBloc, AiringTodayTvShowsState>(
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
