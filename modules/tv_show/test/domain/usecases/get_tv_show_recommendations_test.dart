import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/usecases/get_tv_show_recommendations.dart';
import '../../helpers/mock_helper.mocks.dart';

void main() {
  late MockTvShowRepository repo;
  late GetTvShowRecommendations usecase;

  setUp(() {
    repo = MockTvShowRepository();
    usecase = GetTvShowRecommendations(repo);
  });

  const id = 1;
  final tvShows = <TvShow>[];

  test('Get list of Tv Show Recommendations from the repo', () async {
    // arrange
    when(repo.getTvShowRecommendations(id))
        .thenAnswer((_) async => Right(tvShows));

    // act
    final result = await usecase.execute(id);

    // assert
    expect(result, Right(tvShows));
  });
}
