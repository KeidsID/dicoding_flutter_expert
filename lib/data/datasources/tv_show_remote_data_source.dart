import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common/constants.dart';
import '../../common/exception.dart';
import '../models/tv_show_models/tv_show_model.dart';
import '../models/tv_show_models/tv_show_response.dart';
import '../models/tv_show_models/tv_show_detail_model.dart';

abstract class TvShowRemoteDataSource {
  Future<List<TvShowModel>> getAiringTodayTvShows({int page = 1});
  Future<List<TvShowModel>> getPopularTvShows({int page = 1});
  Future<List<TvShowModel>> getTopRatedTvShows({int page = 1});
  Future<TvShowDetailModel> getTvShowDetail(int id);
  Future<List<TvShowModel>> getTvShowRecommendations(int id);
  Future<List<TvShowModel>> searchTvShows(String query);
}

class TvShowRemoteDataSourceImpl implements TvShowRemoteDataSource {
  TvShowRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<List<TvShowModel>> getAiringTodayTvShows({int page = 1}) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/airing_today?$API_KEY&page=$page'),
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

  @override
  Future<TvShowDetailModel> getTvShowDetail(int id) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/$id?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return TvShowDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getTvShowRecommendations(int id) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> searchTvShows(String query) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'),
    );

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
