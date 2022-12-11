import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:tv_show/data/models/tv_show_model.dart';
import '../../dummy_data/tv_show_dummy_obj.dart';
import '../../json_reader.dart';

void main() {
  group('TvShowModel() test:', () {
    test('Return TvShowModel from JSON data', () {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('dummy_data/tv_show/tv_show.json'),
      );

      // act
      final result = TvShowModel.fromJson(jsonMap);

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
