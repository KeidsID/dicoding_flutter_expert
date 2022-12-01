import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_watchlist_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvShows usecase;
  late MockTvShowRepository mockRepo;

  setUp(() {
    mockRepo = MockTvShowRepository();
    usecase = GetWatchlistTvShows(mockRepo);
  });

  const tvShows = <TvShow>[];

  group('GetWatchlistTvShows test:', () {
    test('Return Right(List<TvShow>) from the repo when success', () async {
      // arrange
      when(mockRepo.getWatchlistTvShows())
          .thenAnswer((_) async => Right(tvShows));

      // act
      final actual = await usecase.execute();

      // assert
      expect(actual, Right(tvShows));
    });
  });
}
