import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/remove_tv_show_from_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show/tv_show_dummy_obj.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvShowFromWatchlist usecase;
  late MockTvShowRepository mockRepo;

  setUp(() {
    mockRepo = MockTvShowRepository();
    usecase = RemoveTvShowFromWatchlist(mockRepo);
  });

  group('RemoveTVShowFromWatchlist usecase test:', () {
    test(
      'Return Right(String) from repo when removing data from Db is successful',
      () async {
        // arrange
        when(mockRepo.removeFromWatchlist(dummyTvShowDetail))
            .thenAnswer((_) async => Right('Success'));

        // act
        final actual = await usecase.execute(dummyTvShowDetail);

        // assert
        expect(actual, Right('Success'));
      },
    );
    test(
      'Return Left(DatabaseFailure) from repo when removing data from Db is fail',
      () async {
        // arrange
        when(mockRepo.removeFromWatchlist(dummyTvShowDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('')));

        // act
        final actual = await usecase.execute(dummyTvShowDetail);

        // assert
        expect(actual, Left(DatabaseFailure('')));
      },
    );
  });
}
