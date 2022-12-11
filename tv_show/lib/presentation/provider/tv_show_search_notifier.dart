import 'package:flutter/cupertino.dart';

import 'package:core/common/state_enum.dart';
import '../../domain/entities/tv_show.dart';
import '../../domain/usecases/search_tv_shows.dart';

class TvShowSearchNotifier extends ChangeNotifier {
  TvShowSearchNotifier({required this.searchTvShows});

  final SearchTvShows searchTvShows;

  List<TvShow> _results = [];
  var _state = RequestState.empty;
  var _msg = '';

  List<TvShow> get results => _results;
  RequestState get state => _state;
  String get msg => _msg;

  Future<void> fetchSearchResults(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);

    result.fold(
      (fail) {
        _msg = fail.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvShows) {
        _results = tvShows;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
