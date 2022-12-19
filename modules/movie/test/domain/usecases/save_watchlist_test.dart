import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/mock_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchlist(mockMovieRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(dummyMovieDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(dummyMovieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlist(dummyMovieDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
