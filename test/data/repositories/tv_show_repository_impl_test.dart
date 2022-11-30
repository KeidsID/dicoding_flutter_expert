import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_model.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show/tv_show_dummy_obj.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRemoteDataSource mockRDataSource;
  late TvShowRepositoryImpl repo;

  setUp(() {
    mockRDataSource = MockTvShowRemoteDataSource();
    repo = TvShowRepositoryImpl(remoteDataSource: mockRDataSource);
  });

  final tvShowModels = <TvShowModel>[testTvShowModel];
  final tvShows = <TvShow>[testTvShow];
  final int tvShowId = testTvShow.id;

  group('TvShowRepositoryImpl', () {
    group('.getAiringTodayTvShows() test:', () {
      test(
        'Return List<TvShow> when remote data source call is successful',
        () async {
          // arrange
          when(mockRDataSource.getAiringTodayTvShows())
              .thenAnswer((_) async => tvShowModels);

          // act
          final result = await repo.getAiringTodayTvShows();

          // assert
          verify(mockRDataSource.getAiringTodayTvShows());

          // https://github.com/spebbe/dartz/issues/80
          final resultList = result | [];
          expect(resultList, tvShows);
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRDataSource.getAiringTodayTvShows())
              .thenThrow(ServerException());

          // act
          final result = await repo.getAiringTodayTvShows();

          // assert
          verify(mockRDataSource.getAiringTodayTvShows());
          expect(result, equals(Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRDataSource.getAiringTodayTvShows())
              .thenThrow(SocketException(failMsg));

          // act
          final result = await repo.getAiringTodayTvShows();

          // assert
          verify(mockRDataSource.getAiringTodayTvShows());
          expect(result, equals(Left(ConnectionFailure(failMsg))));
        },
      );
    });
    group('.getPopularTvShows() test:', () {
      test(
        'Return List<TvShow> when remote data source call is successful',
        () async {
          // arrange
          when(mockRDataSource.getPopularTvShows())
              .thenAnswer((_) async => tvShowModels);

          // act
          final result = await repo.getPopularTvShows();

          // assert
          verify(mockRDataSource.getPopularTvShows());

          // https://github.com/spebbe/dartz/issues/80
          final resultList = result | [];
          expect(resultList, tvShows);
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRDataSource.getPopularTvShows())
              .thenThrow(ServerException());

          // act
          final result = await repo.getPopularTvShows();

          // assert
          verify(mockRDataSource.getPopularTvShows());
          expect(result, equals(Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRDataSource.getPopularTvShows())
              .thenThrow(SocketException(failMsg));

          // act
          final result = await repo.getPopularTvShows();

          // assert
          verify(mockRDataSource.getPopularTvShows());
          expect(result, equals(Left(ConnectionFailure(failMsg))));
        },
      );
    });
    group('.getTopRatedTvShows() test:', () {
      test(
        'Return List<TvShow> when remote data source call is successful',
        () async {
          // arrange
          when(mockRDataSource.getTopRatedTvShows())
              .thenAnswer((_) async => tvShowModels);

          // act
          final result = await repo.getTopRatedTvShows();

          // assert
          verify(mockRDataSource.getTopRatedTvShows());

          // https://github.com/spebbe/dartz/issues/80
          final resultList = result | [];
          expect(resultList, tvShows);
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRDataSource.getTopRatedTvShows())
              .thenThrow(ServerException());

          // act
          final result = await repo.getTopRatedTvShows();

          // assert
          verify(mockRDataSource.getTopRatedTvShows());
          expect(result, equals(Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRDataSource.getTopRatedTvShows())
              .thenThrow(SocketException(failMsg));

          // act
          final result = await repo.getTopRatedTvShows();

          // assert
          verify(mockRDataSource.getTopRatedTvShows());
          expect(result, equals(Left(ConnectionFailure(failMsg))));
        },
      );
    });
    group('.getTvShowDetail() test:', () {
      final detailResponse = TvShowDetailModel(
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
          when(mockRDataSource.getTvShowDetail(tvShowId))
              .thenAnswer((_) async => detailResponse);

          // act
          final result = await repo.getTvShowDetail(tvShowId);

          // assert
          verify(mockRDataSource.getTvShowDetail(tvShowId));
          expect(result, equals(Right(testTvShowDetail)));
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRDataSource.getTvShowDetail(tvShowId))
              .thenThrow(ServerException());

          // act
          final result = await repo.getTvShowDetail(tvShowId);

          // assert
          verify(mockRDataSource.getTvShowDetail(tvShowId));
          expect(result, equals(Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRDataSource.getTvShowDetail(tvShowId))
              .thenThrow(SocketException(failMsg));

          // act
          final result = await repo.getTvShowDetail(tvShowId);

          // assert
          verify(mockRDataSource.getTvShowDetail(tvShowId));
          expect(result, equals(Left(ConnectionFailure(failMsg))));
        },
      );
    });
    group('.getTvShowRecommendations() test:', () {
      test(
        'Return List<TvShow> when remote data source call is successful',
        () async {
          // arrange
          when(mockRDataSource.getTvShowRecommendations(tvShowId))
              .thenAnswer((_) async => tvShowModels);

          // act
          final result = await repo.getTvShowRecommendations(tvShowId);

          // assert
          verify(mockRDataSource.getTvShowRecommendations(tvShowId));

          // https://github.com/spebbe/dartz/issues/80
          final resultList = result | [];
          expect(resultList, tvShows);
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRDataSource.getTvShowRecommendations(tvShowId))
              .thenThrow(ServerException());

          // act
          final result = await repo.getTvShowRecommendations(tvShowId);

          // assert
          verify(mockRDataSource.getTvShowRecommendations(tvShowId));
          expect(result, equals(Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRDataSource.getTvShowRecommendations(tvShowId))
              .thenThrow(SocketException(failMsg));

          // act
          final result = await repo.getTvShowRecommendations(tvShowId);

          // assert
          verify(mockRDataSource.getTvShowRecommendations(tvShowId));
          expect(result, equals(Left(ConnectionFailure(failMsg))));
        },
      );
    });
    group('.searchTvShows() test:', () {
      const query = 'lmao';
      test(
        'Return List<TvShow> when remote data source call is successful',
        () async {
          // arrange
          when(mockRDataSource.searchTvShows(query))
              .thenAnswer((_) async => tvShowModels);

          // act
          final result = await repo.searchTvShows(query);

          // assert
          verify(mockRDataSource.searchTvShows(query));

          // https://github.com/spebbe/dartz/issues/80
          final resultList = result | [];
          expect(resultList, tvShows);
        },
      );
      test(
        'Return ServerFailure() when remote data source call is fail',
        () async {
          // arrange
          when(mockRDataSource.searchTvShows(query))
              .thenThrow(ServerException());

          // act
          final result = await repo.searchTvShows(query);

          // assert
          verify(mockRDataSource.searchTvShows(query));
          expect(result, equals(Left(ServerFailure(''))));
        },
      );
      test(
        'Return ConnectionFailure() when device is not connected to internet',
        () async {
          // arrange
          const failMsg = 'Failed to connect to the network';

          when(mockRDataSource.searchTvShows(query))
              .thenThrow(SocketException(failMsg));

          // act
          final result = await repo.searchTvShows(query);

          // assert
          verify(mockRDataSource.searchTvShows(query));
          expect(result, equals(Left(ConnectionFailure(failMsg))));
        },
      );
    });
  });
}
