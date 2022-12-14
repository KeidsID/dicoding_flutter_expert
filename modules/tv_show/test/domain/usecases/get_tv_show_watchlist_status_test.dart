import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:tv_show/domain/usecases/get_tv_show_watchlist_status.dart';
import '../../helpers/mock_helper.mocks.dart';

void main() {
  late GetTvShowWatchlistStatus usecase;
  late MockTvShowRepository mockRepo;

  setUp(() {
    mockRepo = MockTvShowRepository();
    usecase = GetTvShowWatchlistStatus(mockRepo);
  });

  group('GetTvShowWatchlistStatus test:', () {
    test('Return bool from the repo', () async {
      // arrange
      when(mockRepo.isWatchlisted(1)).thenAnswer((_) async => true);

      // act
      final actual = await usecase.execute(1);

      // assert
      expect(actual, true);
    });
  });
}
