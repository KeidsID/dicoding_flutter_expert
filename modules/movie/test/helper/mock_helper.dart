import 'package:http/io_client.dart';
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
  MockSpec<IOClient>(as: #MockIoClient)
])
void main() {}
