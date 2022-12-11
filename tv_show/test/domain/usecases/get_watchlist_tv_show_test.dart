import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/usecases/get_watchlist_tv_shows.dart';
import '../../helpers/mock_helper.mocks.dart';


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
          .thenAnswer((_) async => const Right(tvShows));

      // act
      final actual = await usecase.execute();

      // assert
      expect(actual, const Right(tvShows));
    });
  });
}
