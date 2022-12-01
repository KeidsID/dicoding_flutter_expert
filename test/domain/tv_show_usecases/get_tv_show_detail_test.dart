import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show/tv_show_dummy_obj.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepo;
  late GetTvShowDetail usecase;

  setUp(() {
    mockTvShowRepo = MockTvShowRepository();
    usecase = GetTvShowDetail(mockTvShowRepo);
  });

  final tvShowId = 1;

  test('Get Tv Show Detail from the repo', () async {
    // arrange
    when(mockTvShowRepo.getTvShowDetail(tvShowId))
        .thenAnswer((_) async => Right(dummyTvShowDetail));

    // act
    final result = await usecase.execute(tvShowId);

    // assert
    expect(result, Right(dummyTvShowDetail));
  });
}
