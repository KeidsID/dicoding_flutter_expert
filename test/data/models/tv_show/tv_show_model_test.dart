import 'dart:convert';

import 'package:ditonton/data/models/tv_show_models/tv_show_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/tv_show/tv_show_dummy_obj.dart';
import '../../../json_reader.dart';

void main() {
  group('TvShowModel() test:', () {
    test('Return TvShowModel from JSON data', () {
      // arrange
      final Map<String, dynamic> JSON = json.decode(
        readJson('dummy_data/tv_show/tv_show.json'),
      );

      // act
      final result = TvShowModel.fromJson(JSON);

      // assert
      expect(result, dummyTvShowModel);
    });
    test('Can convert to entity (Return TvShow)', () {
      // act
      final result = dummyTvShowModel.toEntity();

      // assert
      expect(result, dummyTvShow);
    });
  });
}
