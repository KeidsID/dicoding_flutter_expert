import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:movie/domain/usecases/remove_watchlist.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helper/mock_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveWatchlist(mockMovieRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(dummyMovieDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(dummyMovieDetail);
    // assert
    verify(mockMovieRepository.removeWatchlist(dummyMovieDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
