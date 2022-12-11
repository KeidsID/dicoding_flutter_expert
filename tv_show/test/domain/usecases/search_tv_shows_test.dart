import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/usecases/search_tv_shows.dart';
import '../../helpers/mock_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockRepo;
  late SearchTvShows usecase;

  setUp(() {
    mockRepo = MockTvShowRepository();
    usecase = SearchTvShows(mockRepo);
  });

  const query = 'lmao';
  const tvShows = <TvShow>[];

  group('SearchTvShows test:', () {
    test(
      'Return Right(List<TvShow>) from repo when fetch data success',
      () async {
        // arrange
        when(mockRepo.searchTvShows(query))
            .thenAnswer((_) async => const Right(tvShows));

        // act
        final actual = await usecase.execute(query);

        // assert
        expect(actual, const Right(tvShows));
      },
    );
    test('Return Left(ServerFailure()) from repo when fetch data fail',
        () async {
      // arrange
      when(mockRepo.searchTvShows(query))
          .thenAnswer((_) async => const Left(ServerFailure('')));

      // act
      final actual = await usecase.execute(query);

      // assert
      expect(actual, const Left(ServerFailure('')));
    });
    test(
      'Return Left(ConnectionFailure()) from repo when fetch data fail because Internet Connection',
      () async {
        // arrange
        const msg = 'Failed to connect to the network';
        when(mockRepo.searchTvShows(query))
            .thenAnswer((_) async => const Left(ConnectionFailure(msg)));

        // act
        final actual = await usecase.execute(query);

        // assert
        expect(actual, const Left(ConnectionFailure(msg)));
      },
    );
  });
}
