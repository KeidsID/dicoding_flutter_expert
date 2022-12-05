import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/provider/tv_show/popular_tv_shows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_show/tv_show_dummy_obj.dart';
import '../../../helpers/tv_show_usecase_helper.mocks.dart';

void main() {
  late PopularTvShowsNotifier prov;
  late int notifyCount;
  late MockGetPopularTvShows mockUsecase;

  setUp(() {
    notifyCount = 0;
    mockUsecase = MockGetPopularTvShows();
    prov = PopularTvShowsNotifier(
      getPopularTvShows: mockUsecase,
    )..addListener(() => ++notifyCount);
  });

  const serverFailMsg = 'Server Failure';

  group('PopularTvShowsNotifier', () {
    test('test: Every property initializes empty state', () {
      expect(prov.result, <TvShow>[]);
      expect(prov.state, RequestState.Empty);
      expect(prov.msg, '');
    });
    group('.fetchTvShows() test:', () {
      test('Loading data condition', () {
        when(mockUsecase.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        prov.fetchTvShows();

        expect(prov.state, RequestState.Loading);
        expect(notifyCount, 1);
      });
      test('The condition when fetching data is successful', () async {
        when(mockUsecase.execute()).thenAnswer(
          (_) async => Right([dummyTvShow]),
        );

        await prov.fetchTvShows();

        expect(prov.state, RequestState.Loaded);
        expect(prov.result, [dummyTvShow]);
        expect(notifyCount, 2);
      });
      test('The condition when fetching data is fail\n', () async {
        when(mockUsecase.execute()).thenAnswer(
          (_) async => Left(ServerFailure(serverFailMsg)),
        );

        await prov.fetchTvShows();

        expect(prov.state, RequestState.Error);
        expect(prov.msg, serverFailMsg);
        expect(notifyCount, 2);
      });
    });
  });
}
