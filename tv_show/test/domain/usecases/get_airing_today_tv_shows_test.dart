import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/usecases/get_airing_today_tv_shows.dart';
import '../../helpers/mock_helper.mocks.dart';

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
