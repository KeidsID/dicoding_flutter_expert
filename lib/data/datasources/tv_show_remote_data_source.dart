import 'dart:convert';

import 'package:ditonton/data/models/tv_show_models/tv_show_response.dart';
import 'package:http/http.dart' as http;

import '../../common/constants.dart';
import '../../common/exception.dart';
import '../models/tv_show_models/tv_show_model.dart';

abstract class TvShowRemoteDataSource {
  Future<List<TvShowModel>> getOnAirTvShows();
  Future<List<TvShowModel>> getPopularTvShows();
  Future<List<TvShowModel>> getTopRatedTvShows();
  // Future<TvShowDetailResponse> getTvShowDetail(int id);
  // Future<List<TvShowModel>> getTvShowRecommendations(int id);
  // Future<List<TvShowModel>> searchTvShows(String query);
}

class TvShowRemoteDataSourceImpls implements TvShowRemoteDataSource {
  TvShowRemoteDataSourceImpls({required this.client});

  final http.Client client;

  @override
  Future<List<TvShowModel>> getOnAirTvShows({int page = 1}) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY&page=$page'),
    );

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getPopularTvShows({int page = 1}) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/popular?$API_KEY&page=$page'),
    );

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShows({int page = 1}) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/top_rated?$API_KEY&page=$page'),
    );

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
