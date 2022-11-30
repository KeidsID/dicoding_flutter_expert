import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/search_tv_shows.dart';
import 'package:flutter/cupertino.dart';

class TvShowSearchNotifier extends ChangeNotifier {
  TvShowSearchNotifier({required this.searchTvShows});

  final SearchTvShows searchTvShows;

  List<TvShow> _results = [];
  var _state = RequestState.Empty;
  var _msg = '';

  List<TvShow> get results => _results;
  RequestState get state => _state;
  String get msg => _msg;

  Future<void> fetchSearchResults(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);

    result.fold(
      (fail) {
        _msg = fail.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvShows) {
        _results = tvShows;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
