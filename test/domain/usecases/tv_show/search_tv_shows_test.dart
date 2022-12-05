import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/search_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

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
            .thenAnswer((_) async => Right(tvShows));

        // act
        final actual = await usecase.execute(query);

        // assert
        expect(actual, Right(tvShows));
      },
    );
    test('Return Left(ServerFailure()) from repo when fetch data fail',
        () async {
      // arrange
      when(mockRepo.searchTvShows(query))
          .thenAnswer((_) async => Left(ServerFailure('')));

      // act
      final actual = await usecase.execute(query);

      // assert
      expect(actual, Left(ServerFailure('')));
    });
    test(
      'Return Left(ConnectionFailure()) from repo when fetch data fail because Internet Connection',
      () async {
        // arrange
        const msg = 'Failed to connect to the network';
        when(mockRepo.searchTvShows(query))
            .thenAnswer((_) async => Left(ConnectionFailure(msg)));

        // act
        final actual = await usecase.execute(query);

        // assert
        expect(actual, Left(ConnectionFailure(msg)));
      },
    );
  });
}
