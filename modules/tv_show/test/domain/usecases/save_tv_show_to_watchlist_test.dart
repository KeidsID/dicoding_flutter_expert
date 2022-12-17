import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:tv_show/domain/usecases/save_tv_show_to_watchlist.dart';
import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/mock_helper.mocks.dart';

void main() {
  late SaveTvShowToWatchlist usecase;
  late MockTvShowRepository mockRepo;

  setUp(() {
    mockRepo = MockTvShowRepository();
    usecase = SaveTvShowToWatchlist(mockRepo);
  });

  group('SaveTvShowToWatchlist test:', () {
    test(
      'Return Right(String) from the repo when saving data to Db is successful',
      () async {
        // arrange
        when(mockRepo.saveToWatchlist(dummyTvShowDetail))
            .thenAnswer((_) async => const Right('Success'));

        // act
        final actual = await usecase.execute(dummyTvShowDetail);

        // assert
        expect(actual, const Right('Success'));
      },
    );
    test(
      'Return Left(DatabaseFailure) from the repo when saving data to Db is fail',
      () async {
        // arrange
        when(mockRepo.saveToWatchlist(dummyTvShowDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('')));

        // act
        final actual = await usecase.execute(dummyTvShowDetail);

        // assert
        expect(actual, const Left(DatabaseFailure('')));
      },
    );
  });
}
