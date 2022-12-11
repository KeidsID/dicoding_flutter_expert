import 'package:flutter/foundation.dart';

import 'package:core/common/state_enum.dart';
import '../../domain/entities/tv_show.dart';
import '../../domain/usecases/get_popular_tv_shows.dart';

class PopularTvShowsNotifier extends ChangeNotifier {
  PopularTvShowsNotifier({required this.getPopularTvShows});

  final GetPopularTvShows getPopularTvShows;

  var _tvShows = <TvShow>[];
  var _state = RequestState.empty;
  var _message = '';

  List<TvShow> get result => _tvShows;
  RequestState get state => _state;
  String get msg => _message;

  Future<void> fetchTvShows({int page = 1}) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvShows.execute(page: page);
    result.fold(
      (failure) {
        _state = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (movies) {
        _state = RequestState.loaded;
        _tvShows = movies;
        notifyListeners();
      },
    );
  }
}