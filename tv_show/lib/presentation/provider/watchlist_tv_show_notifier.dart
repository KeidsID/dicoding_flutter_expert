import 'package:flutter/foundation.dart';

import 'package:core/common/state_enum.dart';
import '../../domain/entities/tv_show.dart';
import '../../domain/usecases/get_watchlist_tv_shows.dart';

class WatchlistTvShowNotifier extends ChangeNotifier {
  WatchlistTvShowNotifier({required this.getWatchlistTvShows});

  final GetWatchlistTvShows getWatchlistTvShows;

  var _tvShows = <TvShow>[];
  var _state = RequestState.empty;
  var _msg = '';

  List<TvShow> get results => _tvShows;
  RequestState get state => _state;
  String get msg => _msg;

  Future<void> fetchTvShows() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTvShows.execute();

    result.fold(
      (fail) {
        _state = RequestState.error;
        _msg = fail.message;
        notifyListeners();
      },
      (tvShows) {
        _state = RequestState.loaded;
        _tvShows = tvShows;
        notifyListeners();
      },
    );
  }
}
