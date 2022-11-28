import 'package:ditonton/common/constants.dart';
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

  group('TvShowRemoteDataSource()', () {
    final tvShowListJsonStr = readJson('dummy_data/tv_show/tv_show_list.json');
    group('.getAiringTodayTvShows() test:', () {
      test('Return List<TvShowModel> when the response code is 200', () async {
        // arrange
        when(mockClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
            .thenAnswer((_) async => http.Response(tvShowListJsonStr, 200));

        // act
        final actual = await dataSource.getAiringTodayTvShows();

        // assert
        expect(actual, equals(testTvShowResponse.results));
      });
    });
  });
}
