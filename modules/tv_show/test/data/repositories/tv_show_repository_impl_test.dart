import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';
import 'package:core/models/genre_model.dart';
import 'package:tv_show/data/models/tv_show_detail_model.dart';
import 'package:tv_show/data/models/tv_show_model.dart';
import 'package:tv_show/data/repositories/tv_show_repository_impl.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/mock_helper.mocks.dart';

void main() {
  late MockTvShowRemoteDataSource mockRemoteDS;
  late MockTvShowLocalDataSource mockLocalDS;
  late TvShowRepositoryImpl repo;

  setUp(() {
    mockRemoteDS = MockTvShowRemoteDataSource();
    mockLocalDS = MockTvShowLocalDataSource();
    repo = TvShowRepositoryImpl(
      remoteDataSource: mockRemoteDS,
      localDataSource: mockLocalDS,
    );
  });

  final tvShowModels = <TvShowModel>[dummyTvShowModel];
  final tvShows = <TvShow>[dummyTvShow];
  final int tvShowId = dummyTvShow.id;

  group('TvShowRepositoryImpl', () {
    group('.getAiringTodayTvShows() test:', () {
      test(
        'Return List<TvShow> when remote data source call is successful',
        () async {
          // arrange
          when(mockRemoteDS.getAiringTodayTvShows())
              .thenAnswer((_) async => tvShowModels);

          // act
          final result = await repo.getAiringTodayTvShows();

          // assert
          verify(mockRemoteDS.getAiringTodayTvShows());

          // https://github.com/spebbe/dartz/issues/80
          final resultList = result | [];
          expect(resultList, tvShows);
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRemoteDS.getAiringTodayTvShows())
              .thenThrow(ServerException());

          // act
          final result = await repo.getAiringTodayTvShows();

          // assert
          verify(mockRemoteDS.getAiringTodayTvShows());
          expect(result, equals(const Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet\n',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRemoteDS.getAiringTodayTvShows())
              .thenThrow(const SocketException(failMsg));

          // act
          final result = await repo.getAiringTodayTvShows();

          // assert
          verify(mockRemoteDS.getAiringTodayTvShows());
          expect(result, equals(const Left(ConnectionFailure(failMsg))));
        },
      );
    });
    group('.getPopularTvShows() test:', () {
      test(
        'Return List<TvShow> when remote data source call is successful',
        () async {
          // arrange
          when(mockRemoteDS.getPopularTvShows())
              .thenAnswer((_) async => tvShowModels);

          // act
          final result = await repo.getPopularTvShows();

          // assert
          verify(mockRemoteDS.getPopularTvShows());

          // https://github.com/spebbe/dartz/issues/80
          final resultList = result | [];
          expect(resultList, tvShows);
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRemoteDS.getPopularTvShows()).thenThrow(ServerException());

          // act
          final result = await repo.getPopularTvShows();

          // assert
          verify(mockRemoteDS.getPopularTvShows());
          expect(result, equals(const Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet\n',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRemoteDS.getPopularTvShows())
              .thenThrow(const SocketException(failMsg));

          // act
          final result = await repo.getPopularTvShows();

          // assert
          verify(mockRemoteDS.getPopularTvShows());
          expect(result, equals(const Left(ConnectionFailure(failMsg))));
        },
      );
    });
    group('.getTopRatedTvShows() test:', () {
      test(
        'Return List<TvShow> when remote data source call is successful',
        () async {
          // arrange
          when(mockRemoteDS.getTopRatedTvShows())
              .thenAnswer((_) async => tvShowModels);

          // act
          final result = await repo.getTopRatedTvShows();

          // assert
          verify(mockRemoteDS.getTopRatedTvShows());

          // https://github.com/spebbe/dartz/issues/80
          final resultList = result | [];
          expect(resultList, tvShows);
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRemoteDS.getTopRatedTvShows()).thenThrow(ServerException());

          // act
          final result = await repo.getTopRatedTvShows();

          // assert
          verify(mockRemoteDS.getTopRatedTvShows());
          expect(result, equals(const Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet\n',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRemoteDS.getTopRatedTvShows())
              .thenThrow(const SocketException(failMsg));

          // act
          final result = await repo.getTopRatedTvShows();

          // assert
          verify(mockRemoteDS.getTopRatedTvShows());
          expect(result, equals(const Left(ConnectionFailure(failMsg))));
        },
      );
    });
    group('.getTvShowDetail() test:', () {
      const detailResponse = TvShowDetailModel(
        backdropPath: '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
        genres: <GenreModel>[
          GenreModel(id: 10765, name: 'Sci-Fi & Fantasy'),
          GenreModel(id: 18, name: 'Drama'),
          GenreModel(id: 10759, name: 'Action & Adventure'),
          GenreModel(id: 9648, name: 'Mystery'),
        ],
        homepage: '',
        id: 1399,
        name: 'Game of Thrones',
        numberOfEpisodes: 73,
        numberOfSeasons: 8,
        originalName: 'Game of Thrones',
        overview:
            "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
        popularity: 369.594,
        posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
        voteAverage: 8.3,
        voteCount: 11504,
      );

      test(
        'Return TvShowDetail() when remote data source call is successful',
        () async {
          // arrange
          when(mockRemoteDS.getTvShowDetail(tvShowId))
              .thenAnswer((_) async => detailResponse);

          // act
          final result = await repo.getTvShowDetail(tvShowId);

          // assert
          verify(mockRemoteDS.getTvShowDetail(tvShowId));
          expect(result, equals(const Right(dummyTvShowDetail)));
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRemoteDS.getTvShowDetail(tvShowId))
              .thenThrow(ServerException());

          // act
          final result = await repo.getTvShowDetail(tvShowId);

          // assert
          verify(mockRemoteDS.getTvShowDetail(tvShowId));
          expect(result, equals(const Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet\n',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRemoteDS.getTvShowDetail(tvShowId))
              .thenThrow(const SocketException(failMsg));

          // act
          final result = await repo.getTvShowDetail(tvShowId);

          // assert
          verify(mockRemoteDS.getTvShowDetail(tvShowId));
          expect(result, equals(const Left(ConnectionFailure(failMsg))));
        },
      );
    });
    group('.getTvShowRecommendations() test:', () {
      test(
        'Return List<TvShow> when remote data source call is successful',
        () async {
          // arrange
          when(mockRemoteDS.getTvShowRecommendations(tvShowId))
              .thenAnswer((_) async => tvShowModels);

          // act
          final result = await repo.getTvShowRecommendations(tvShowId);

          // assert
          verify(mockRemoteDS.getTvShowRecommendations(tvShowId));

          // https://github.com/spebbe/dartz/issues/80
          final resultList = result | [];
          expect(resultList, tvShows);
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRemoteDS.getTvShowRecommendations(tvShowId))
              .thenThrow(ServerException());

          // act
          final result = await repo.getTvShowRecommendations(tvShowId);

          // assert
          verify(mockRemoteDS.getTvShowRecommendations(tvShowId));
          expect(result, equals(const Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet\n',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRemoteDS.getTvShowRecommendations(tvShowId))
              .thenThrow(const SocketException(failMsg));

          // act
          final result = await repo.getTvShowRecommendations(tvShowId);

          // assert
          verify(mockRemoteDS.getTvShowRecommendations(tvShowId));
          expect(result, equals(const Left(ConnectionFailure(failMsg))));
        },
      );
    });
    group('.searchTvShows() test:', () {
      const query = 'lmao';
      test(
        'Return List<TvShow> when remote data source call is successful',
        () async {
          // arrange
          when(mockRemoteDS.searchTvShows(query))
              .thenAnswer((_) async => tvShowModels);

          // act
          final result = await repo.searchTvShows(query);

          // assert
          verify(mockRemoteDS.searchTvShows(query));

          // https://github.com/spebbe/dartz/issues/80
          final resultList = result | [];
          expect(resultList, tvShows);
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRemoteDS.searchTvShows(query)).thenThrow(ServerException());

          // act
          final result = await repo.searchTvShows(query);

          // assert
          verify(mockRemoteDS.searchTvShows(query));
          expect(result, equals(const Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet\n',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRemoteDS.searchTvShows(query))
              .thenThrow(const SocketException(failMsg));

          // act
          final result = await repo.searchTvShows(query);

          // assert
          verify(mockRemoteDS.searchTvShows(query));
          expect(result, equals(const Left(ConnectionFailure(failMsg))));
        },
      );
    });
    group('.getWatchlistTvShows() test:', () {
      test('Return List<TvShow> from local data source\n', () async {
        // arrange
        when(mockLocalDS.getWatchlistTvShows())
            .thenAnswer((_) async => [dummyTvTable]);

        // act
        final result = await repo.getWatchlistTvShows();

        // assert
        final actual = result | [];
        expect(actual, [dummyTvShowFromDb]);
      });
    });
    group('.isWatchlisted() test:', () {
      test('Return true when data is found', () async {
        // arrange
        when(mockLocalDS.getTvShowById(1))
            .thenAnswer((_) async => dummyTvTable);

        // act
        final actual = await repo.isWatchlisted(1);

        // assert
        expect(actual, true);
      });
      test('Return false when data is not found\n', () async {
        // arrange
        when(mockLocalDS.getTvShowById(1)).thenAnswer((_) async => null);

        // act
        final actual = await repo.isWatchlisted(1);

        // assert
        expect(actual, false);
      });
    });
    group('.saveToWatchlist() test:', () {
      test('Return Right(String) when saving successful', () async {
        // arrange
        when(mockLocalDS.insertWatchlist(dummyTvTable))
            .thenAnswer((_) async => 'Success');

        // act
        final actual = await repo.saveToWatchlist(dummyTvShowDetailForDbTest);

        // assert
        expect(actual, const Right('Success'));
      });
      test('Return Left(DatabaseFailure) when saving UnSuccessful\n', () async {
        // arrange
        when(mockLocalDS.insertWatchlist(dummyTvTable))
            .thenThrow(DatabaseException('Fail to save'));

        // act
        final actual = await repo.saveToWatchlist(dummyTvShowDetailForDbTest);

        // assert
        expect(actual, const Left(DatabaseFailure('Fail to save')));
      });
    });
    group('.removeFromWatchlist() test:', () {
      test('Return Right(String) when remove successful', () async {
        // arrange
        when(mockLocalDS.removeWatchlist(dummyTvTable))
            .thenAnswer((_) async => 'Success');

        // act
        final actual =
            await repo.removeFromWatchlist(dummyTvShowDetailForDbTest);

        // assert
        expect(actual, const Right('Success'));
      });
      test('Return Left(DatabaseFailure) when remove UnSuccessful\n', () async {
        // arrange
        when(mockLocalDS.removeWatchlist(dummyTvTable))
            .thenThrow(DatabaseException('Fail to remove'));

        // act
        final actual =
            await repo.removeFromWatchlist(dummyTvShowDetailForDbTest);

        // assert
        expect(actual, const Left(DatabaseFailure('Fail to remove')));
      });
    });
  });
}
