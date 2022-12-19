import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_show/data/models/tv_show_response.dart';

import '../../dummy_data/tv_show_dummy_json_str.dart';
import '../../dummy_data/tv_show_dummy_obj.dart';

void main() {
  test('Return TvShowResponse() from JSON data', () {
    // arrange
    final Map<String, dynamic> jsonStr = json.decode(dummyTvShowListJson);

    // act
    final actual = TvShowResponse.fromJson(jsonStr);

    // assert
    expect(actual, dummyTvShowResponse);
  });
}
