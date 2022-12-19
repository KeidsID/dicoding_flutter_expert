import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:tv_show/domain/usecases/remove_tv_show_from_watchlist.dart';
import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/mock_helper.mocks.dart';

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
            .thenAnswer((_) async => const Right('Success'));

        // act
        final actual = await usecase.execute(dummyTvShowDetail);

        // assert
        expect(actual, const Right('Success'));
      },
    );
    test(
      'Return Left(DatabaseFailure) from repo when removing data from Db is fail',
      () async {
        // arrange
        when(mockRepo.removeFromWatchlist(dummyTvShowDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('')));

        // act
        final actual = await usecase.execute(dummyTvShowDetail);

        // assert
        expect(actual, const Left(DatabaseFailure('')));
      },
    );
  });
}
