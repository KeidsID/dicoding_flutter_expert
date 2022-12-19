import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

import 'package:tv_show/data/datasources/db/tv_show_db_helper.dart';
import 'package:tv_show/data/datasources/tv_show_local_data_source.dart';
import 'package:tv_show/data/datasources/tv_show_remote_data_source.dart';
import 'package:tv_show/domain/repositories/tv_show_repository.dart';

@GenerateMocks([
  TvShowRepository,
  TvShowRemoteDataSource,
  TvShowLocalDataSource,
  TvShowDbHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockIoClient)
])
void main() {}
