import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:tv_show/domain/usecases/get_tv_show_detail.dart';
import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/mock_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepo;
  late GetTvShowDetail usecase;

  setUp(() {
    mockTvShowRepo = MockTvShowRepository();
    usecase = GetTvShowDetail(mockTvShowRepo);
  });

  const tvShowId = 1;

  test('Get Tv Show Detail from the repo', () async {
    // arrange
    when(mockTvShowRepo.getTvShowDetail(tvShowId))
        .thenAnswer((_) async => const Right(dummyTvShowDetail));

    // act
    final result = await usecase.execute(tvShowId);

    // assert
    expect(result, const Right(dummyTvShowDetail));
  });
}
