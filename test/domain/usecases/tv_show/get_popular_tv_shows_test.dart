import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_popular_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_show/tv_show_dummy_obj.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepo;
  late GetPopularTvShows usecase;

  setUp(() {
    mockTvShowRepo = MockTvShowRepository();
    usecase = GetPopularTvShows(mockTvShowRepo);
  });

  final tvShows = <TvShow>[];
  final tvShows2 = <TvShow>[dummyTvShow];

  group('GetPopularTvShows Tests:', () {
    test('Get list of Tv Shows from repo', () async {
      // arrange
      when(mockTvShowRepo.getPopularTvShows())
          .thenAnswer((_) async => Right(tvShows));

      // act
      final results = await usecase.execute();

      // assert
      expect(results, Right(tvShows));
    });
    test('Get list of Tv Shows from repo with page param', () async {
      // arrange
      const page = 2;
      when(mockTvShowRepo.getPopularTvShows(page: page))
          .thenAnswer((_) async => Right(tvShows2));

      // act
      final results = await usecase.execute(page: page);

      // assert
      expect(results, Right(tvShows2));
    });
  });
}
