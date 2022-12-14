import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv_show/data/datasources/tv_show_remote_data_source.dart';

import '../../dummy_data/tv_show_dummy_json_str.dart';
import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../helpers/mock_helper.mocks.dart';

void main() {
  late MockIoClient mockClient;
  late TvShowRemoteDataSourceImpl dataSource;

  setUp(() {
    mockClient = MockIoClient();
    dataSource = TvShowRemoteDataSourceImpl(ioClient: mockClient);
  });

  group('TvShowRemoteDataSource', () {
    const tId = 1;
    group('.getAiringTodayTvShows() test:', () {
      test('Return List<TvShowModel> when the response code is 200', () async {
        // arrange
        when(mockClient
                .get(Uri.parse('$kApiBaseUrl/tv/airing_today?$kApiKey&page=1')))
            .thenAnswer(
          (_) async => http.Response(
            dummyTvShowListJson,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.getAiringTodayTvShows();

        // assert
        expect(actual, equals(dummyTvShowResponse.results));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(mockClient
                .get(Uri.parse('$kApiBaseUrl/tv/airing_today?$kApiKey&page=1')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final actual = dataSource.getAiringTodayTvShows();

        // assert
        expect(() => actual, throwsA(isA<ServerException>()));
      });
    });
    group('.getPopularTvShows() test:', () {
      test('Return List<TvShowModel> when the response code is 200', () async {
        // arrange
        when(mockClient
                .get(Uri.parse('$kApiBaseUrl/tv/popular?$kApiKey&page=1')))
            .thenAnswer(
          (_) async => http.Response(
            dummyTvShowListJson,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.getPopularTvShows();

        // assert
        expect(actual, equals(dummyTvShowResponse.results));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(mockClient
                .get(Uri.parse('$kApiBaseUrl/tv/popular?$kApiKey&page=1')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final actual = dataSource.getPopularTvShows();

        // assert
        expect(() => actual, throwsA(isA<ServerException>()));
      });
    });
    group('.getTopRatedTvShows() test:', () {
      test('Return List<TvShowModel> when the response code is 200', () async {
        // arrange
        when(
          mockClient
              .get(Uri.parse('$kApiBaseUrl/tv/top_rated?$kApiKey&page=1')),
        ).thenAnswer(
          (_) async => http.Response(
            dummyTvShowListJson,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.getTopRatedTvShows();

        // assert
        expect(actual, equals(dummyTvShowResponse.results));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(
          mockClient
              .get(Uri.parse('$kApiBaseUrl/tv/top_rated?$kApiKey&page=1')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final actual = dataSource.getTopRatedTvShows();

        // assert
        expect(() => actual, throwsA(isA<ServerException>()));
      });
    });
    group('.getTvShowDetail() test:', () {
      test('Return TvShowDetailModel when the response code is 200', () async {
        // arrange
        when(mockClient.get(
          Uri.parse('$kApiBaseUrl/tv/$tId?$kApiKey'),
        )).thenAnswer(
          (_) async => http.Response(
            dummyTvShowDetailJson,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.getTvShowDetail(tId);

        // assert
        expect(actual, equals(dummyTvShowDetailModel));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(mockClient.get(
          Uri.parse('$kApiBaseUrl/tv/$tId?$kApiKey'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final actual = dataSource.getTvShowDetail(tId);

        // assert
        expect(() => actual, throwsA(isA<ServerException>()));
      });
    });
    group('.getTvShowRecommendations() test:', () {
      test('Return List<TvShowModel> when the response code is 200', () async {
        // arrange
        when(mockClient.get(
          Uri.parse('$kApiBaseUrl/tv/$tId/recommendations?$kApiKey'),
        )).thenAnswer(
          (_) async => http.Response(
            dummyTvShowListJson,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.getTvShowRecommendations(tId);

        // assert
        expect(actual, equals(dummyTvShowResponse.results));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(mockClient.get(
          Uri.parse('$kApiBaseUrl/tv/$tId/recommendations?$kApiKey'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final actual = dataSource.getTvShowRecommendations(tId);

        // assert
        expect(() => actual, throwsA(isA<ServerException>()));
      });
    });
    group('.searchTvShows() test:', () {
      const query = 'lmao';
      test('Return List<TvShowModel> when the response code is 200', () async {
        // arrange
        when(mockClient.get(
          Uri.parse('$kApiBaseUrl/search/tv?$kApiKey&query=$query'),
        )).thenAnswer(
          (_) async => http.Response(
            dummyTvShowListJson,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.searchTvShows(query);

        // assert
        expect(actual, equals(dummyTvShowResponse.results));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(mockClient.get(
          Uri.parse('$kApiBaseUrl/search/tv?$kApiKey&query=$query'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final actual = dataSource.searchTvShows(query);

        // assert
        expect(() => actual, throwsA(isA<ServerException>()));
      });
    });
  });
}
