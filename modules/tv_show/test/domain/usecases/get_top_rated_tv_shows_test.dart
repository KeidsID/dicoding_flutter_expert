import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/usecases/get_top_rated_tv_shows.dart';
import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/mock_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepo;
  late GetTopRatedTvShows usecase;

  setUp(() {
    mockTvShowRepo = MockTvShowRepository();
    usecase = GetTopRatedTvShows(mockTvShowRepo);
  });

  final tvShows = <TvShow>[];
  final tvShows2 = <TvShow>[dummyTvShow];

  group('GetTopRatedTvShows Tests:', () {
    test('Get list of Tv Shows from repo', () async {
      // arrange
      when(mockTvShowRepo.getTopRatedTvShows())
          .thenAnswer((_) async => Right(tvShows));

      // act
      final results = await usecase.execute();

      // assert
      expect(results, Right(tvShows));
    });
    test('Get list of Tv Shows from repo with page param', () async {
      // arrange
      const page = 2;
      when(mockTvShowRepo.getTopRatedTvShows(page: page))
          .thenAnswer((_) async => Right(tvShows2));

      // act
      final results = await usecase.execute(page: page);

      // assert
      expect(results, Right(tvShows2));
    });
  });
}
