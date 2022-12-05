import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_airing_today_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepo;
  late GetAiringTodayTvShows usecase;

  setUp(() {
    mockTvShowRepo = MockTvShowRepository();
    usecase = GetAiringTodayTvShows(mockTvShowRepo);
  });

  final tvShows = <TvShow>[];

  test(
    'Get list of Tv Shows from the repository',
    () async {
      // arrange
      when(mockTvShowRepo.getAiringTodayTvShows())
          .thenAnswer((_) async => Right(tvShows));

      // act
      final results = await usecase.execute();

      // assert
      expect(results, Right(tvShows));
    },
  );
}
