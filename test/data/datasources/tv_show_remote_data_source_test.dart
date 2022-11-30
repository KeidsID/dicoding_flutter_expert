import 'dart:io';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_show_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show/tv_show_dummy_obj.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late MockHttpClient mockClient;
  late TvShowRemoteDataSourceImpl dataSource;

  setUp(() {
    mockClient = MockHttpClient();
    dataSource = TvShowRemoteDataSourceImpl(client: mockClient);
  });

  group('TvShowRemoteDataSource', () {
    final tvShowListJsonStr = readJson('dummy_data/tv_show/tv_show_list.json');
    final tvShowDetailJsonStr = readJson(
      'dummy_data/tv_show/tv_show_detail.json',
    );
    final tId = 1;
    group('.getAiringTodayTvShows() test:', () {
      test('Return List<TvShowModel> when the response code is 200', () async {
        // arrange
        when(mockClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
            .thenAnswer(
          (_) async => http.Response(
            tvShowListJsonStr,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.getAiringTodayTvShows();

        // assert
        expect(actual, equals(testTvShowResponse.results));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(mockClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
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
        when(mockClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY&page=1')))
            .thenAnswer(
          (_) async => http.Response(
            tvShowListJsonStr,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.getPopularTvShows();

        // assert
        expect(actual, equals(testTvShowResponse.results));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(mockClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY&page=1')))
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
          mockClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY&page=1')),
        ).thenAnswer(
          (_) async => http.Response(
            tvShowListJsonStr,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.getTopRatedTvShows();

        // assert
        expect(actual, equals(testTvShowResponse.results));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(
          mockClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY&page=1')),
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
          Uri.parse('$BASE_URL/tv/$tId?$API_KEY'),
        )).thenAnswer(
          (_) async => http.Response(
            tvShowDetailJsonStr,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.getTvShowDetail(tId);

        // assert
        expect(actual, equals(testTvShowDetailModel));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(mockClient.get(
          Uri.parse('$BASE_URL/tv/$tId?$API_KEY'),
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
          Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY'),
        )).thenAnswer(
          (_) async => http.Response(
            tvShowListJsonStr,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.getTvShowRecommendations(tId);

        // assert
        expect(actual, equals(testTvShowResponse.results));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(mockClient.get(
          Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY'),
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
          Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'),
        )).thenAnswer(
          (_) async => http.Response(
            tvShowListJsonStr,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final actual = await dataSource.searchTvShows(query);

        // assert
        expect(actual, equals(testTvShowResponse.results));
      });
      test('Throw a ServerException when the response code is NOT 200',
          () async {
        // arrange
        when(mockClient.get(
          Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final actual = dataSource.searchTvShows(query);

        // assert
        expect(() => actual, throwsA(isA<ServerException>()));
      });
    });
  });
}
