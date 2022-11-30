import 'package:flutter/foundation.dart';

import '../../../common/state_enum.dart';
import '../../../domain/usecases/tv_show_cases/get_watchlist_tv_shows.dart';
import '../../../domain/entities/tv_show.dart';

class WatchlistTvShowNotifier extends ChangeNotifier {
  WatchlistTvShowNotifier({required this.getWatchlistTvShows});

  final GetWatchlistTvShows getWatchlistTvShows;

  var _tvShows = <TvShow>[];
  var _state = RequestState.Empty;
  var _msg = '';

  List<TvShow> get results => _tvShows;
  RequestState get state => _state;
  String get msg => _msg;

  Future<void> fetchTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvShows.execute();

    result.fold(
      (fail) {
        _state = RequestState.Error;
        _msg = fail.message;
        notifyListeners();
      },
      (tvShows) {
        _state = RequestState.Loaded;
        _tvShows = tvShows;
        notifyListeners();
      },
    );
  }
}
