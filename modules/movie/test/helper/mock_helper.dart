import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie/data/data_source/db/movie_db_helper.dart';
import 'package:movie/data/data_source/movie_local_data_source.dart';

import 'package:movie/data/data_source/movie_remote_data_source.dart';
import 'package:movie/domain/repo/movie_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  MovieDbHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
