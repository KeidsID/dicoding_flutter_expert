import 'package:flutter/foundation.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv_show.dart';
import '../../../domain/usecases/tv_show_cases/get_top_rated_tv_shows.dart';

class TopRatedTvShowsNotifier extends ChangeNotifier {
  TopRatedTvShowsNotifier({required this.getTopRatedTvShows});

  final GetTopRatedTvShows getTopRatedTvShows;

  var _tvShows = <TvShow>[];
  var _state = RequestState.Empty;
  var _message = '';

  List<TvShow> get result => _tvShows;
  RequestState get state => _state;
  String get msg => _message;

  Future<void> fetchTvShows({int page = 1}) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute(page: page);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movies) {
        _state = RequestState.Loaded;
        _tvShows = movies;
        notifyListeners();
      },
    );
  }
}
