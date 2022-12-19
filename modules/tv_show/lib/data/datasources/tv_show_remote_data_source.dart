import 'dart:convert';

import 'package:core/common/constants.dart';
import 'package:core/common/exception.dart';
import 'package:http/io_client.dart';
import '../models/tv_show_model.dart';
import '../models/tv_show_response.dart';
import '../models/tv_show_detail_model.dart';

abstract class TvShowRemoteDataSource {
  Future<List<TvShowModel>> getAiringTodayTvShows({int page = 1});
  Future<List<TvShowModel>> getPopularTvShows({int page = 1});
  Future<List<TvShowModel>> getTopRatedTvShows({int page = 1});
  Future<TvShowDetailModel> getTvShowDetail(int id);
  Future<List<TvShowModel>> getTvShowRecommendations(int id);
  Future<List<TvShowModel>> searchTvShows(String query);
}

class TvShowRemoteDataSourceImpl implements TvShowRemoteDataSource {
  final IOClient ioClient;

  TvShowRemoteDataSourceImpl({required this.ioClient});

  @override
  Future<List<TvShowModel>> getAiringTodayTvShows({int page = 1}) async {
    final response = await ioClient.get(
      Uri.parse('$kApiBaseUrl/tv/airing_today?$kApiKey&page=$page'),
    );

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getPopularTvShows({int page = 1}) async {
    final response = await ioClient.get(
      Uri.parse('$kApiBaseUrl/tv/popular?$kApiKey&page=$page'),
    );

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShows({int page = 1}) async {
    final response = await ioClient.get(
      Uri.parse('$kApiBaseUrl/tv/top_rated?$kApiKey&page=$page'),
    );

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvShowDetailModel> getTvShowDetail(int id) async {
    final response = await ioClient.get(
      Uri.parse('$kApiBaseUrl/tv/$id?$kApiKey'),
    );

    if (response.statusCode == 200) {
      return TvShowDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getTvShowRecommendations(int id) async {
    final response = await ioClient.get(
      Uri.parse('$kApiBaseUrl/tv/$id/recommendations?$kApiKey'),
    );

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> searchTvShows(String query) async {
    final response = await ioClient.get(
      Uri.parse('$kApiBaseUrl/search/tv?$kApiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
