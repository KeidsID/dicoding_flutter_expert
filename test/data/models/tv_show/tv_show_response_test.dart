import 'dart:convert';

import 'package:ditonton/data/models/tv_show_models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/tv_show/tv_show_dummy_obj.dart';
import '../../../json_reader.dart';

void main() {
  test('Return TvShowResponse() from JSON data', () {
    // arrange
    final Map<String, dynamic> jsonStr = json.decode(
      readJson('dummy_data/tv_show/tv_show_list.json'),
    );

    // act
    final actual = TvShowResponse.fromJson(jsonStr);

    // assert
    final matcher = testTvShowResponse;
    expect(actual, matcher);
  });
}
